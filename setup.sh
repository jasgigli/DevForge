# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Node.js dependencies
pnpm install

# Build Rust components
cargo build

# Build TypeScript packages
pnpm build

# Link for local development
pnpm link -g