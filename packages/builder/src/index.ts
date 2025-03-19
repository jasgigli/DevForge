import * as esbuild from "esbuild";
import { optimizeAssets } from "./optimize";
import { generateSourceMaps } from "./sourcemaps";

export interface BuildConfig {
  entry: string;
  output: string;
  plugins?: string[];
  minify?: boolean;
  sourcemap?: boolean;
  target?: string[];
}

export class Builder {
  private config: BuildConfig;

  constructor(config: BuildConfig) {
    this.config = {
      minify: true,
      sourcemap: true,
      target: ["es2020"],
      ...config,
    };
  }

  async build(): Promise<void> {
    try {
      // Build process
      await esbuild.build({
        entryPoints: [this.config.entry],
        outdir: this.config.output || "dist",
        bundle: true,
        minify: this.config.minify,
        sourcemap: this.config.sourcemap,
        target: this.config.target,
        plugins: this.loadPlugins(),
      });

      if (this.config.minify) {
        await optimizeAssets();
      }

      if (this.config.sourcemap) {
        await generateSourceMaps();
      }

      console.log("Build completed successfully!");
    } catch (error) {
      console.error("Build failed:", error);
      throw error; // Let the caller handle the error
    }
  }

  private loadPlugins(): esbuild.Plugin[] {
    // Here you could implement plugin loading logic
    return [];
  }
}
