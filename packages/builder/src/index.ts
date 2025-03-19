import { build as esbuild } from 'esbuild';
import { optimizeAssets } from './optimize';
import { generateSourceMaps } from './sourcemaps';

export class Builder {
  private config: any;

  constructor(config: any) {
    this.config = config;
  }

  async build() {
    try {
      // Build process
      await esbuild({
        entryPoints: [this.config.entry],
        bundle: true,
        minify: true,
        sourcemap: true,
        outdir: 'dist',
      });

      await optimizeAssets();
      await generateSourceMaps();
    } catch (error) {
      console.error('Build failed:', error);
      process.exit(1);
    }
  }
}