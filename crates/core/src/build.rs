use anyhow::Result;

pub struct BuildConfig {
    pub target: String,
    pub release: bool,
}

pub fn build(config: BuildConfig) -> Result<()> {
    println!("Building for target: {} (release: {})", config.target, config.release);
    Ok(())
}