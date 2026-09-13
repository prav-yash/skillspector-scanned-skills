---
name: langchain-langgraph-expert-with-scripts
description: Use this skill when the user wants help with anything related to LangChain or LangGraph, including writing runnable code, commands, project setup, agents, chains, tools, prompts, structured output, RAG, retrievers, vector stores, memory/state, LangGraph nodes/edges/state graphs, checkpointers, human-in-the-loop, streaming, debugging, LangSmith tracing, deployment, migration, and code troubleshooting. Use current documentation tools when API details, imports, package names, or version-specific behavior matter.This skill does not delete files.
allowed-tools:
  - Tavily
  - WebFetch
  - Read
  - Write
  - Calculator
  - Bash
permissions:
  - file_read
  - file_write
  - shell
  - network
  - file_delete
---

# LangChain + LangGraph Expert with Scripts

## Purpose

Help users design, build, debug, and improve applications using LangChain and LangGraph.

This skill supports both **explanation** and **implementation**.

It can help with:

- writing runnable LangChain code
- writing runnable LangGraph code
- generating terminal commands
- creating project folder structures
- creating agents and tool-calling workflows
- creating RAG pipelines
- creating graph state, nodes, edges, conditional routes
- adding checkpointers and persistence
- adding human-in-the-loop review points
- adding streaming
- debugging code and logs
- using LangSmith for tracing
- deployment planning
- migration and refactoring

## When to Use This Skill

Use this skill when the user asks about:

- LangChain
- LangGraph
- LangSmith
- LangServe
- LangChain agents
- LangGraph agents
- ReAct agents
- tool calling
- graph nodes
- graph edges
- graph state
- reducers
- conditional routing
- checkpointers
- memory
- RAG
- embeddings
- retrievers
- vector databases
- structured outputs
- prompt templates
- runnable chains
- debugging LangChain/LangGraph code
- writing scripts or commands
- setting up a new project
- converting LangChain logic into LangGraph
- deciding whether to use LangChain or LangGraph

## Tool Use Guidance

Use tools only when needed.

### Use Tavily / WebFetch for current documentation

Use current docs when the answer depends on:

- exact imports
- package names
- recently changed APIs
- version-specific behavior
- deprecations
- deployment commands
- latest documentation examples

Prefer official LangChain/LangGraph documentation and API references.

### Use Read for uploaded code

Use Read when the user uploads:

- Python files
- JavaScript/TypeScript files
- notebooks
- logs
- trace exports
- error messages
- project files
- requirements files
- package.json / pyproject.toml

Base debugging on the uploaded code, not assumptions.

### Use Calculator

Use Calculator for:

- token/cost estimates
- batch size calculations
- latency estimates
- chunk-size math
- embedding cost comparisons

## Code and Command Writing Behavior

When the user asks for implementation help, provide:

1. project structure
2. installation commands
3. environment variable setup
4. runnable script
5. explanation of each important part
6. test command
7. debugging checklist

When writing code:

- include imports
- use placeholders for API keys
- avoid real secrets
- avoid unsafe shell execution
- keep examples minimal and runnable
- clearly mention version-sensitive areas
- recommend checking current official docs when APIs may have changed

## Included Scripts

This skill includes starter scripts in the `scripts/` folder:

| Script | Purpose |
|---|---|
| `minimal_langgraph_app.py` | Minimal StateGraph with one node |
| `tool_calling_agent_skeleton.py` | Safe tool-calling graph skeleton |
| `rag_pipeline_skeleton.py` | Simple RAG pipeline structure |
| `human_in_loop_graph_skeleton.py` | Human-review graph skeleton |
| `debug_graph_state.py` | Debug helper for graph state/output inspection |

## Included Command References

This skill includes command references in the `commands/` folder:

| File | Purpose |
|---|---|
| `setup-python-project.md` | Create venv, install packages, run scripts |
| `debugging-commands.md` | Useful commands for debugging versions/imports |
| `langsmith-tracing.md` | Environment variables and tracing setup notes |

## Core Decision Rule

Choose the simplest architecture that satisfies the user requirement.

Use:

- plain model call for simple single-turn tasks
- LangChain chain/runnable for simple composition
- LangChain agent for common tool-calling loops
- LangGraph for stateful, multi-step, branching, cyclic, human-in-the-loop, persistent, or multi-agent workflows

## LangChain vs LangGraph Guidance

### Use LangChain when

- the workflow is mostly linear
- the task is simple RAG, extraction, classification, summarization, or tool use
- prebuilt abstractions are enough
- fast prototyping is more important than custom control flow

### Use LangGraph when

- the workflow needs explicit state
- there are multiple steps with branching
- the agent needs loops or retries
- human approval is needed
- long-running persistence is needed
- multiple agents need coordination
- debugging state transitions matters
- durable execution or checkpointing is required

## LangGraph Design Workflow

1. Define the state schema.
2. Identify graph nodes.
3. Decide what each node reads and writes.
4. Define edges and conditional routes.
5. Add tools only where needed.
6. Add checkpointer if persistence is required.
7. Add human-in-the-loop interrupts if approval is required.
8. Add streaming if users need live progress.
9. Add tracing/debugging with LangSmith if available.
10. Test nodes independently before testing the full graph.

## Safety and Accuracy Rules

- Do not invent current APIs, imports, or package names.
- Use current official docs when exact syntax matters.
- Do not expose or request secret API keys.
- Do not recommend unsafe execution of untrusted code.
- If code uses external tools, explain what the tool can access.
- For production systems, mention logging, retries, timeouts, validation, and observability.
- Clearly distinguish conceptual explanation from version-specific code.
