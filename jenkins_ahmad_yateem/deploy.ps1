$ErrorActionPreference = "Stop"
$APP_DIR = $env:WORKSPACE
$TARGET_DIR = Join-Path $env:WORKSPACE "deploy"
New-Item -ItemType Directory -Force -Path $TARGET_DIR | Out-Null
Copy-Item -Path (Join-Path $APP_DIR "app.py") -Destination $TARGET_DIR -Force
python -m py_compile (Join-Path $TARGET_DIR "app.py")
"deployed" | Set-Content (Join-Path $TARGET_DIR "status.txt")
