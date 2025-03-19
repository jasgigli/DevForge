# Stop on first error
$ErrorActionPreference = "Stop"

# Get version from package.json
$VERSION = (Get-Content "package.json" | ConvertFrom-Json).version

Write-Host "Building DevForge v$VERSION for release..." -ForegroundColor Cyan

# Create necessary directories
Write-Host "Creating directories..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path "packages/cli/bin" | Out-Null
New-Item -ItemType Directory -Force -Path "packages/cli/dist" | Out-Null

# Build Rust binary
Write-Host "Building Rust components..." -ForegroundColor Cyan
try {
    cargo build --release
    if ($LASTEXITCODE -ne 0) { 
        Write-Host "Rust build failed" -ForegroundColor Red
        exit 1 
    }
} catch {
    Write-Host "Rust build failed: $_" -ForegroundColor Red
    exit 1
}

# Copy Rust binary to CLI package
Write-Host "Copying Rust binary..." -ForegroundColor Cyan
$BINARY_NAME = "devforge.exe"
Copy-Item "target/release/$BINARY_NAME" "packages/cli/bin/" -Force

# Build all packages
Write-Host "Building TypeScript packages..." -ForegroundColor Cyan
try {
    pnpm build
    if ($LASTEXITCODE -ne 0) { 
        Write-Host "TypeScript build failed" -ForegroundColor Red
        exit 1 
    }
} catch {
    Write-Host "TypeScript build failed: $_" -ForegroundColor Red
    exit 1
}

Write-Host "Build complete!" -ForegroundColor Green
