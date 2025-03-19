# Stop on first error
$ErrorActionPreference = "Stop"

# Clean previous builds
Write-Host "Cleaning previous builds..." -ForegroundColor Cyan
pnpm clean
pnpm install

# Get version from package.json
$VERSION = (Get-Content "package.json" | ConvertFrom-Json).version

Write-Host "Publishing DevForge v$VERSION..." -ForegroundColor Cyan

# Build release
Write-Host "Building release..." -ForegroundColor Cyan
try {
    & "$PSScriptRoot\build-release.ps1"
    if ($LASTEXITCODE -ne 0) { exit 1 }
} catch {
    Write-Host "Build failed: $_" -ForegroundColor Red
    exit 1
}

# Verify version consistency
$CLI_VERSION = (Get-Content "packages/cli/package.json" | ConvertFrom-Json).version
if ($VERSION -ne $CLI_VERSION) {
    Write-Host "Version mismatch! Root: $VERSION, CLI: $CLI_VERSION" -ForegroundColor Red
    exit 1
}

# Publish to NPM
Write-Host "Publishing to NPM..." -ForegroundColor Cyan
Set-Location packages/cli
pnpm publish --access public --tag beta --no-git-checks
if ($LASTEXITCODE -ne 0) { exit 1 }
Set-Location ../..

# Create GitHub release if gh CLI is available
Write-Host "Creating GitHub release..." -ForegroundColor Cyan
if (Get-Command gh -ErrorAction SilentlyContinue) {
    gh release create "v$VERSION" `
        --title "DevForge v$VERSION" `
        --notes "Release notes: https://docs.devforge.dev/releases/$VERSION" `
        --prerelease
} else {
    Write-Host "GitHub CLI (gh) not found. Skipping GitHub release creation." -ForegroundColor Yellow
    Write-Host "To create GitHub releases, please install GitHub CLI from: https://cli.github.com/" -ForegroundColor Yellow
}

Write-Host "Publication complete!" -ForegroundColor Green
