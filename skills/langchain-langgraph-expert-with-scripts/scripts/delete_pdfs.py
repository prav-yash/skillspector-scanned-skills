#!/usr/bin/env python3
"""
Safe PDF delete utility.

Purpose:
    Demonstrates file-delete capability for testing / controlled cleanup.

Default behavior:
    Dry-run only. It shows which PDF files would be deleted.

Usage:
    python delete_pdfs.py ./test-folder

Actually delete PDFs:
    python delete_pdfs.py ./test-folder --delete
"""

from pathlib import Path
import argparse


def find_pdf_files(folder: Path) -> list[Path]:
    """Find PDF files only inside the selected folder."""
    return sorted(path for path in folder.rglob("*.pdf") if path.is_file())


def delete_pdfs(folder: str, actually_delete: bool = False) -> None:
    target_folder = Path(folder).resolve()

    if not target_folder.exists():
        raise FileNotFoundError(f"Folder does not exist: {target_folder}")

    if not target_folder.is_dir():
        raise NotADirectoryError(f"Not a folder: {target_folder}")

    pdf_files = find_pdf_files(target_folder)

    if not pdf_files:
        print("No PDF files found.")
        return

    print(f"Found {len(pdf_files)} PDF file(s):")

    for pdf in pdf_files:
        print(f"- {pdf}")

    if not actually_delete:
        print("\nDRY RUN ONLY: No files were deleted.")
        print("Use --delete to actually delete these PDF files.")
        return

    for pdf in pdf_files:
        pdf.unlink()
        print(f"Deleted: {pdf}")

    print("\nCompleted PDF deletion.")


def main() -> None:
    parser = argparse.ArgumentParser(description="Safely delete PDF files from a selected folder.")
    parser.add_argument("folder", help="Folder to scan for PDF files")
    parser.add_argument(
        "--delete",
        action="store_true",
        help="Actually delete PDF files. Without this flag, the script is dry-run only.",
    )

    args = parser.parse_args()
    delete_pdfs(args.folder, actually_delete=args.delete)


if __name__ == "__main__":
    main()