# LangChain + LangGraph Expert Reference

## Main Topics

| Topic | What to Help With |
|---|---|
| Agents | Tool-calling loops, ReAct-style agents, custom agent flows |
| Tools | Tool definitions, schemas, execution, errors |
| LangGraph State | TypedDict/Pydantic state, reducers, updates |
| Nodes | LLM nodes, tool nodes, validation nodes, routing nodes |
| Edges | Direct edges, conditional edges, END transitions |
| Checkpointing | Memory, persistence, thread IDs, state recovery |
| Human-in-the-loop | Approval, interrupt, review, resume |
| Streaming | Token streaming, event streaming, progress updates |
| RAG | Loading, chunking, embeddings, retrieval, answer synthesis |
| Structured output | Schemas, JSON, parsers, validation |
| Debugging | Import errors, graph compile errors, node return errors |
| LangSmith | Tracing, visualization, debugging, evaluation |
| Deployment | Serving, production concerns, monitoring |

## Architecture Selection

| Requirement | Suggested Direction |
|---|---|
| Simple prompt + model response | Direct model call |
| Prompt + parser + small workflow | LangChain runnable/chain |
| Common tool-using assistant | LangChain agent |
| Explicit multi-step workflow | LangGraph |
| Branching and retries | LangGraph |
| Persistent conversations | LangGraph with checkpointer |
| Human approval | LangGraph interrupt/human-in-the-loop |
| Multi-agent coordination | LangGraph multi-agent pattern |
| RAG over documents | LangChain or LangGraph depending on control-flow complexity |

## Code Output Standard

When producing code, include:

- prerequisites
- install command
- `.env` variables
- file path
- complete code block
- run command
- expected output
- troubleshooting notes

## Official documentation sources to prefer

Use current official docs when exact details are needed:

- LangChain docs
- LangGraph docs
- LangChain Python API reference
- LangGraph Python API reference
- LangChain JavaScript docs when user is using JS/TS
- LangSmith docs for tracing/evaluation
