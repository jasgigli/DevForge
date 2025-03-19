use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct Config {
    pub project: ProjectConfig,
    pub build: BuildConfig,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ProjectConfig {
    pub name: String,
    pub version: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct BuildConfig {
    pub target: String,
    pub optimize: bool,
}

pub fn load_config(path: &str) -> Config {
    Config {
        project: ProjectConfig {
            name: String::from("default"),
            version: String::from("0.1.0"),
        },
        build: BuildConfig {
            target: String::from("release"),
            optimize: true,
        },
    }
}