# LangSmith Tracing Notes

Use LangSmith when you need tracing, debugging, or evaluation visibility.

## Environment variables

```bash
export LANGSMITH_TRACING=true
export LANGSMITH_API_KEY=your_key_here
export LANGSMITH_PROJECT=your_project_name
```

### Windows PowerShell

```powershell
$env:LANGSMITH_TRACING="true"
$env:LANGSMITH_API_KEY="your_key_here"
$env:LANGSMITH_PROJECT="your_project_name"
```

Do not commit real API keys.

Exact environment variable names and setup can change, so verify with current LangSmith docs when using in production.
