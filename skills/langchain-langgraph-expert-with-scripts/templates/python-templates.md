# LangChain + LangGraph Code Templates

## Minimal LangGraph StateGraph Pattern

```python
from typing import TypedDict
from langgraph.graph import StateGraph, START, END

class AppState(TypedDict):
    input: str
    output: str

def process(state: AppState) -> dict:
    return {"output": f"Processed: {state['input']}"}

graph_builder = StateGraph(AppState)
graph_builder.add_node("process", process)
graph_builder.add_edge(START, "process")
graph_builder.add_edge("process", END)

graph = graph_builder.compile()

result = graph.invoke({"input": "hello", "output": ""})
print(result)
```

## Tool-Calling Agent Checklist

1. Define tools with clear input schemas.
2. Bind tools to model or route tools through a graph node.
3. Ensure tool outputs are returned in the expected message format.
4. Add guardrails for tool permissions.
5. Add tracing for debugging.
6. Add retries/timeouts for production.
7. Test each tool independently.

## RAG Checklist

1. Load documents.
2. Split into chunks.
3. Create embeddings.
4. Store in vector store.
5. Retrieve relevant chunks.
6. Pass retrieved context to model.
7. Require answer grounding.
8. Cite or show source snippets when possible.
9. Say when context is insufficient.
