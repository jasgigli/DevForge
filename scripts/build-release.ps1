# Stop on first error
$ErrorActionPreference = "Stop"

# Get version from package.json
$VERSION = (Get-Content "package.json" | ConvertFrom-Json).version

Write-Host "🎁 Building DevForge v$VERSION for release..." -ForegroundColor Cyan

# Create necessary directories
Write-Host "📁 Creating directories..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path "packages/cli/bin"
New-Item -ItemType Directory -Force -Path "packages/cli/dist"
New-Item -ItemType Directory -Force -Path "crates/build-tools/src"
New-Item -ItemType Directory -Force -Path "crates/cli-bridge/src"
New-Item -ItemType Directory -Force -Path "packages/config/src"

# Install global dependencies
Write-Host "📦 Installing global dependencies..." -ForegroundColor Cyan
npm install -g rimraf

# Clean previous builds
Write-Host "🧹 Cleaning previous builds..." -ForegroundColor Cyan
pnpm clean

# Install dependencies
Write-Host "📦 Installing dependencies..." -ForegroundColor Cyan
pnpm install

# Initialize Git if not already initialized
if (-not (Test-Path ".git")) {
    Write-Host "🔧 Initializing Git repository..." -ForegroundColor Cyan
    git init
    git add .
    git commit -m "Initial commit"
}

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

Write-Host "✨ Build complete!" -ForegroundColor Green

