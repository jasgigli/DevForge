# Stop on first error
$ErrorActionPreference = "Stop"

# Get version from package.json
$VERSION = (Get-Content "package.json" | ConvertFrom-Json).version

Write-Host "🎁 Building DevForge v$VERSION for release..." -ForegroundColor Cyan

# Clean previous builds
Write-Host "🧹 Cleaning previous builds..." -ForegroundColor Cyan
pnpm clean

# Install dependencies
Write-Host "📦 Installing dependencies..." -ForegroundColor Cyan
pnpm install

# Build Rust binary
Write-Host "🦀 Building Rust components..." -ForegroundColor Cyan
cargo build --release
if ($LASTEXITCODE -ne 0) { exit 1 }

# Copy Rust binary to CLI package
Write-Host "📋 Copying Rust binary..." -ForegroundColor Cyan
$BINARY_NAME = "devforge.exe"
Copy-Item "target/release/$BINARY_NAME" "packages/cli/bin/" -Force

# Build all packages
Write-Host "📦 Building TypeScript packages..." -ForegroundColor Cyan
pnpm build
if ($LASTEXITCODE -ne 0) { exit 1 }

# Run tests
Write-Host "🧪 Running tests..." -ForegroundColor Cyan
pnpm test
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "✨ Build complete!" -ForegroundColor Green