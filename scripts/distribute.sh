#!/bin/bash
set -e

VERSION=$(node -p "require('./package.json').version")

# Build all packages
pnpm build

# Publish to NPM
echo "Publishing to NPM..."
cd packages/cli
pnpm publish --access public --tag beta

# Create GitHub release
echo "Creating GitHub release..."
gh release create "v$VERSION" \
  --title "DevForge v$VERSION" \
  --notes "Release notes: https://docs.devforge.dev/releases/$VERSION" \
  --prerelease

# Update Homebrew
echo "Updating Homebrew formula..."
brew tap devforge/tools
sed -i '' "s/version \".*\"/version \"$VERSION\"/" Formula/devforge.rb
git -C "$(brew --repo devforge/tools)" commit -am "devforge $VERSION"
git -C "$(brew --repo devforge/tools)" push

echo "Distribution complete for version $VERSION"