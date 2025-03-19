import { z } from 'zod';

export const ConfigSchema = z.object({
  project: z.object({
    name: z.string(),
    type: z.enum(['react', 'vue', 'node']),
    entry: z.string(),
  }),
  tools: z.object({
    bundler: z.enum(['auto', 'webpack', 'vite', 'esbuild']),
    linter: z.enum(['auto', 'eslint']),
    formatter: z.enum(['auto', 'prettier']),
    testing: z.enum(['auto', 'jest', 'vitest']),
  }),
});

export type DevForgeConfig = z.infer<typeof ConfigSchema>;

export class ConfigManager {
  private config: DevForgeConfig;

  constructor(configPath: string) {
    // Load and validate config
  }

  public getConfig(): DevForgeConfig {
    return this.config;
  }
}