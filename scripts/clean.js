const fs = require('fs');
const path = require('path');

const dirsToClean = [
  'packages/*/dist',
  'packages/*/bin',
  'target'
];

function deleteFolderRecursive(path) {
  if (fs.existsSync(path)) {
    fs.readdirSync(path).forEach((file) => {
      const curPath = path + "/" + file;
      if (fs.lstatSync(curPath).isDirectory()) {
        deleteFolderRecursive(curPath);
      } else {
        fs.unlinkSync(curPath);
      }
    });
    fs.rmdirSync(path);
  }
}

dirsToClean.forEach(pattern => {
  const basePath = process.cwd();
  const [packagesDir, subDir] = pattern.split('/');
  
  if (packagesDir === 'packages') {
    fs.readdirSync(path.join(basePath, packagesDir)).forEach(pkg => {
      const targetDir = path.join(basePath, packagesDir, pkg, subDir);
      if (fs.existsSync(targetDir)) {
        deleteFolderRecursive(targetDir);
        console.log(`Cleaned ${targetDir}`);
      }
    });
  } else {
    const targetDir = path.join(basePath, pattern);
    if (fs.existsSync(targetDir)) {
      deleteFolderRecursive(targetDir);
      console.log(`Cleaned ${targetDir}`);
    }
  }
});