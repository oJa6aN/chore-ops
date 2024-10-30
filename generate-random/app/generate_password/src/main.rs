use rand::Rng;
use std::env;

fn generate_password(length: usize) -> String {
    let charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:',.<>?/`~";

    (0..length)
        .map(|_| {
            let idx = rand::thread_rng().gen_range(0..charset.len());
            charset.chars().nth(idx).unwrap()
        })
        .collect()
}

fn main() {
    let args: Vec<String> = env::args().collect();

    println!(
        "{}",
        generate_password(args.get(1).and_then(|s| s.parse().ok()).unwrap_or(15))
    );
}
