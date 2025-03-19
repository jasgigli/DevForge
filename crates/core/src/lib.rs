pub mod build;
pub mod compiler;
pub mod config;
pub mod performance;

pub struct DevForgeCore {
    config: config::Config,
}

impl DevForgeCore {
    pub fn new(config: config::Config) -> Self {
        Self { config }
    }

    pub async fn initialize(&self) -> anyhow::Result<()> {
        // Initialize core systems
        Ok(())
    }
}