# Using DevForge

## 1. Command Line Interface (CLI)
Primary way to use DevForge:

```bash
# Create new project
devforge new my-app

# Start development
devforge dev

# Build project
devforge build

# Run tests
devforge test

# Format code
devforge format
```

## 2. Configuration File
Project configuration through `devforge.config.ts`:

```typescript
{
  project: {
    type: "react",
    entry: "src/index.tsx"
  },
  tools: {
    bundler: "auto",
    linter: "auto",
    formatter: "auto",
    testing: "auto"
  }
}
```

## 3. IDE Integration
- VS Code Extension (coming soon)
- IDE-specific configurations auto-generated

## 4. API Usage
For programmatic access in Node.js applications:

```typescript
import { DevForge } from '@devforge/core';

const forge = new DevForge({
  project: {
    type: 'react'
  }
});

await forge.createProject('my-app');
await forge.startDev();
```