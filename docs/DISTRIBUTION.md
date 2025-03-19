# DevForge Distribution

## 1. NPM Package (Primary)
```bash
# Global installation
npm install -g @devforge/cli

# Local project installation
npm install --save-dev @devforge/cli
```

## 2. Native Binaries
Pre-built binaries for major platforms:
- Windows (.exe)
- macOS (universal binary)
- Linux (AppImage)

## 3. Package Managers
```bash
# Homebrew (macOS)
brew install devforge

# Windows (winget)
winget install devforge

# Linux (apt)
sudo apt install devforge
```

## 4. Docker Image
```bash
# Pull Docker image
docker pull devforge/cli

# Run in container
docker run -v $(pwd):/app devforge/cli new my-app
```