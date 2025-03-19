# Verify package contents
Write-Host "🔍 Verifying package contents..." -ForegroundColor Cyan

# Pack without publishing
Set-Location packages/cli
$PACK_OUTPUT = (pnpm pack --dry-run)
Set-Location ../..

# Check required files
$REQUIRED_FILES = @(
    "bin/devforge.exe",
    "dist/index.js",
    "dist/index.d.ts",
    "README.md",
    "package.json"
)

$MISSING_FILES = $false
foreach ($file in $REQUIRED_FILES) {
    if ($PACK_OUTPUT -notmatch $file) {
        Write-Host "❌ Missing required file: $file" -ForegroundColor Red
        $MISSING_FILES = $true
    }
}

if ($MISSING_FILES) {
    Write-Host "❌ Verification failed: Missing required files" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Package verification successful!" -ForegroundColor Green