use std::time::{Duration, Instant};

pub struct PerformanceMetrics {
    pub build_time: Duration,
    pub memory_usage: u64,
}

pub fn measure_performance<F>(operation: F) -> PerformanceMetrics 
where
    F: FnOnce() -> ()
{
    let start = Instant::now();
    operation();
    let duration = start.elapsed();

    PerformanceMetrics {
        build_time: duration,
        memory_usage: 0, // Placeholder for actual memory measurement
    }
}