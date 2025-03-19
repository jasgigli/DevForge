pub mod build;
pub mod compiler;
pub mod config;
pub mod performance;

pub use build::BuildConfig;
pub use compiler::CompilerOptions;
pub use config::Config;
pub use performance::PerformanceMetrics;

pub fn init() -> &'static str {
    "DevForge Core initialized"
}
