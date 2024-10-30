use rand::Rng;

fn generate_random_number(args: &[String]) -> f64 {
    let mut rng = rand::thread_rng();

    match args.len() {
        0 => {
            // No arguments, generate a random floating-point number
            rng.gen()
        }
        1 => {
            // One argument, use it as the maximum
            let max: f64 = args[0].parse().expect("Please provide a valid number");
            rng.gen_range(0.0..max)
        }
        2 => {
            // Two arguments, first is the minimum and second is the maximum
            let min: f64 = args[0].parse().expect("Please provide a valid number");
            let max: f64 = args[1].parse().expect("Please provide a valid number");
            rng.gen_range(min..max)
        }
        _ => {
            panic!("Invalid number of arguments. Usage: generate_random_number [max] or generate_random_number [min max]");
        }
    }
}

fn main() {
    let args: Vec<String> = std::env::args().skip(1).collect();
    let result = generate_random_number(&args);
    println!("{}", result);
}
