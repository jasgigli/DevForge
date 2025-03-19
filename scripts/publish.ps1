# Stop on first error
$ErrorActionPreference = "Stop"

# Get version from package.json
$VERSION = (Get-Content "package.json" | ConvertFrom-Json).version

Write-Host "🚀 Publishing DevForge v$VERSION..." -ForegroundColor Cyan

# Build release
Write-Host "🔨 Building release..." -ForegroundColor Cyan
.\scripts\build-release.ps1
if ($LASTEXITCODE -ne 0) { exit 1 }

# Publish to NPM
Write-Host "📦 Publishing to NPM..." -ForegroundColor Cyan
Set-Location packages/cli
pnpm publish --access public --tag beta
if ($LASTEXITCODE -ne 0) { exit 1 }
Set-Location ../..

# Create GitHub release
Write-Host "🎉 Creating GitHub release..." -ForegroundColor Cyan
gh release create "v$VERSION" `
    --title "DevForge v$VERSION" `
    --notes "Release notes: https://docs.devforge.dev/releases/$VERSION" `
    --prerelease

Write-Host "✨ Publication complete!" -ForegroundColor Green