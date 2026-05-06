import { mkdirSync, copyFileSync } from 'node:fs';
mkdirSync('dist', { recursive: true });
copyFileSync('src/index.mjs', 'dist/index.js');
console.log('built dist/index.js');
