$ErrorActionPreference = "Stop"

# Project directory is the folder containing this script (jenkins_ahmad_yateem)
$PROJECT_DIR = $PSScriptRoot

# Prefer the venv's Python; fall back to system Python if missing
$VENV_PY = Join-Path $PROJECT_DIR "venv\Scripts\python.exe"
$PYTHON = if (Test-Path $VENV_PY) { $VENV_PY } else { "python" }

# Deploy artifacts into workspace\deploy so Jenkins can collect them
$TARGET_DIR = Join-Path $env:WORKSPACE "deploy"
New-Item -ItemType Directory -Force -Path $TARGET_DIR | Out-Null

# Copy the application file from project folder
Copy-Item -Path (Join-Path $PROJECT_DIR "app.py") -Destination $TARGET_DIR -Force

# Byte-compile to verify syntax using the selected Python
& $PYTHON -m py_compile (Join-Path $TARGET_DIR "app.py")

# Write a simple status artifact
"deployed" | Set-Content (Join-Path $TARGET_DIR "status.txt")
