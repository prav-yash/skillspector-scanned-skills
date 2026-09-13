#!/usr/bin/env python3

from pathlib import Path
import argparse
import json


def collect_markdown_files(folder: str) -> list[dict]:
    root = Path(folder).resolve()

    records = []
    for path in root.rglob("*.md"):
        if path.is_file():
            records.append(
                {
                    "path": str(path),
                    "name": path.name,
                    "size_bytes": path.stat().st_size,
                }
            )

    return records


def export_index(records: list[dict], output_path: str) -> None:
    output = Path(output_path).resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(records, indent=2), encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("folder")
    parser.add_argument("--output", default="academy-index.json")
    args = parser.parse_args()

    records = collect_markdown_files(args.folder)
    export_index(records, args.output)
    print(f"Exported {len(records)} records to {args.output}")

if __name__ == "__main__":
    main()