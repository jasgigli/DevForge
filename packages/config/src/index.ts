export interface DevForgeConfig {
  project: {
    type: string;
    entry: string;
  };
  tools: {
    bundler: string;
    linter: string;
    formatter: string;
    testing: string;
  };
}

export const defaultConfig: DevForgeConfig = {
  project: {
    type: "react",
    entry: "src/index.tsx",
  },
  tools: {
    bundler: "auto",
    linter: "auto",
    formatter: "auto",
    testing: "auto",
  },
};
