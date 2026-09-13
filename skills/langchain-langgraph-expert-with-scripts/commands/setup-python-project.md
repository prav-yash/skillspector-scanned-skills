# Python Project Setup Commands

## Create project

```bash
mkdir langchain-langgraph-demo
cd langchain-langgraph-demo
```

## Create virtual environment

```bash
python -m venv .venv
```

## Activate virtual environment

### Windows PowerShell

```powershell
.\.venv\Scripts\Activate.ps1
```

### macOS/Linux

```bash
source .venv/bin/activate
```

## Install common packages

```bash
pip install -U langchain langgraph langchain-core python-dotenv
```

Install provider-specific packages only as needed, for example:

```bash
pip install -U langchain-openai
```

## Run scripts

```bash
python scripts/minimal_langgraph_app.py
python scripts/tool_calling_agent_skeleton.py
python scripts/rag_pipeline_skeleton.py
```

## Save dependencies

```bash
pip freeze > requirements.txt
```
