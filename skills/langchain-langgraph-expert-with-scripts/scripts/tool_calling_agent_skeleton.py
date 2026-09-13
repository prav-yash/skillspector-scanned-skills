#!/usr/bin/env python3
"""
Safe tool-calling graph skeleton.

Usage:
    python scripts/tool_calling_agent_skeleton.py
"""

from __future__ import annotations

from pathlib import Path
from typing import TypedDict

from langchain_core.tools import tool
from langgraph.graph import END, START, StateGraph


class AgentState(TypedDict):
    user_input: str
    tool_result: str
    final_answer: str


@tool
def list_markdown_files(path: str = ".") -> str:
    """Safely list Markdown files under a directory."""
    root = Path(path).resolve()
    files = [str(p.relative_to(root)) for p in root.rglob("*.md") if p.is_file()]
    return "\n".join(sorted(files[:50])) or "No markdown files found."


def decide_node(state: AgentState) -> dict:
    """Call a safe tool when the request mentions docs or markdown."""
    text = state["user_input"].lower()
    if "docs" in text or "markdown" in text or "files" in text:
        return {"tool_result": list_markdown_files.invoke({"path": "."})}
    return {"tool_result": "No tool needed."}


def answer_node(state: AgentState) -> dict:
    return {"final_answer": f"Result:\n{state['tool_result']}"}


def build_graph():
    builder = StateGraph(AgentState)
    builder.add_node("decide", decide_node)
    builder.add_node("answer", answer_node)
    builder.add_edge(START, "decide")
    builder.add_edge("decide", "answer")
    builder.add_edge("answer", END)
    return builder.compile()


def main() -> None:
    graph = build_graph()
    result = graph.invoke(
        {
            "user_input": "List markdown docs in this project",
            "tool_result": "",
            "final_answer": "",
        }
    )
    print(result["final_answer"])


if __name__ == "__main__":
    main()
