#!/bin/bash
set -e

# Install Rust if not installed
if ! command -v rustup &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi

# Install Node.js dependencies
if ! command -v pnpm &> /dev/null; then
    npm install -g pnpm
fi

# Install dependencies
pnpm install

# Build Rust components
cargo build

# Build TypeScript packages
pnpm build

# Setup git hooks
pnpm prepare

echo "DevForge development environment setup complete!"
```
</augment_snippet>

7. Release Workflow:

<augment_code_snippet path="devforge/.github/workflows/release.yml" mode="EDIT">
```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          registry-url: 'https://registry.npmjs.org'
      
      - name: Setup Rust
        uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
          
      - name: Setup PNPM
        uses: pnpm/action-setup@v2
        with:
          version: 8
      
      - name: Install dependencies
        run: pnpm install
          
      - name: Build packages
        run: pnpm build
        
      - name: Run tests
        run: pnpm test
        
      - name: Publish to NPM
        run: |
          cd packages/cli
          pnpm publish --no-git-checks --tag beta
        env:
          NODE_AUTH_TOKEN: ${{secrets.NPM_TOKEN}}