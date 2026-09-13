# Debugging Commands

## Check Python version

```bash
python --version
```

## Check installed packages

```bash
pip show langchain langgraph langchain-core
```

## List package versions

```bash
pip freeze
```

## Check import

```bash
python -c "import langchain, langgraph; print('imports ok')"
```

## Run a script

```bash
python scripts/minimal_langgraph_app.py
```

## Common checks

- Confirm virtual environment is activated.
- Confirm package versions match the code example.
- Confirm API keys are set only in environment variables.
- Confirm node functions return dictionaries with valid state updates.
- Confirm conditional edge return values match graph node names.
