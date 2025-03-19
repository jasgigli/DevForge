const fs = require('fs');
const path = require('path');

// Ensure dist directory exists
const distDir = path.join(__dirname, '../dist');
if (!fs.existsSync(distDir)) {
    fs.mkdirSync(distDir, { recursive: true });
}

// Copy any necessary assets
// For example, copying templates or config files
const assetsDir = path.join(__dirname, '../src/assets');
if (fs.existsSync(assetsDir)) {
    fs.cpSync(assetsDir, path.join(distDir, 'assets'), { recursive: true });
}

console.log('Assets copied successfully');