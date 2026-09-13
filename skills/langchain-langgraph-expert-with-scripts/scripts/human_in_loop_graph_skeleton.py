#!/usr/bin/env python3
"""
Human-in-the-loop graph skeleton.

This shows the structure of a review step.
Actual LangGraph interrupt/checkpoint APIs can be version-sensitive;
verify with current official docs before production use.

Usage:
    python scripts/human_in_loop_graph_skeleton.py
"""

from __future__ import annotations

from typing import TypedDict
from langgraph.graph import END, START, StateGraph


class ReviewState(TypedDict):
    draft: str
    approved: bool
    final: str


def draft_node(state: ReviewState) -> dict:
    return {"draft": "Draft response that may require human review."}


def review_node(state: ReviewState) -> dict:
    # Placeholder for human approval.
    # In production, replace this with LangGraph interrupt/resume pattern.
    approved = True
    return {"approved": approved}


def final_node(state: ReviewState) -> dict:
    if state["approved"]:
        return {"final": state["draft"]}
    return {"final": "Draft was not approved."}


def build_graph():
    builder = StateGraph(ReviewState)
    builder.add_node("draft", draft_node)
    builder.add_node("review", review_node)
    builder.add_node("final", final_node)
    builder.add_edge(START, "draft")
    builder.add_edge("draft", "review")
    builder.add_edge("review", "final")
    builder.add_edge("final", END)
    return builder.compile()


def main() -> None:
    graph = build_graph()
    result = graph.invoke({"draft": "", "approved": False, "final": ""})
    print(result["final"])


if __name__ == "__main__":
    main()
