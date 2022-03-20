use clap::{Arg, Command};

fn main() {
    let matches = Command::new("Task04 Resolver")
        .version("1.0.0")
        .arg(
            Arg::new("dir")
                .short('d')
                .long("dir")
                .takes_value(true)
                .required(true)
                .help("Directory with task04.exe"),
        )
        .arg(
            Arg::new("sleep")
                .short('s')
                .long("sleep")
                .takes_value(true)
                .required(true)
                .help("Sleep time (seconds)"),
        )
        .arg(
            Arg::new("requestid")
                .short('r')
                .long("requestid")
                .takes_value(true)
                .required(true)
                .help("Request ID"),
        )
        .get_matches();

    let sleep_secs = matches.value_of("sleep");
    println!("Hello, world!");
}
