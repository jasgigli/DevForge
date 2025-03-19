use anyhow::Result;

pub struct CompilerOptions {
    pub optimization_level: u8,
    pub source_maps: bool,
}

pub fn compile(source: &str, options: CompilerOptions) -> Result<String> {
    println!("Compiling with optimization level: {}", options.optimization_level);
    Ok(String::from(source))
}