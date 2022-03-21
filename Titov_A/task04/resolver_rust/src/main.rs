extern crate core;

use clap::{Arg, ArgMatches, Command};
use std::num::ParseIntError;
use std::panic;

trait PathTrait {
    fn calc_path_chksum(&self) -> u16;
}

impl PathTrait for String {
    fn calc_path_chksum(&self) -> u16 {
        0x1004 // TODO: implement
    }
}

#[derive(Debug)]
struct AppData {
    dir: String,
    sleep: u8,
    request_id: u8,
}

impl AppData {
    pub fn prepare_key(&self) -> u32 {
        let sleep_result = 0x10 - (self.sleep & 0xF);
        ((sleep_result as u32 & 0xF) << 0x18)
            | ((0xD) << 0x14)
            | ((self.dir.calc_path_chksum() as u32 & 0xFFFF) << 4)
            | (self.request_id as u32 & 0xF)
    }
}

enum ArgKeys {
    Dir,
    RequestId,
    Sleep,
}

impl ArgKeys {
    fn as_str(&self) -> &'static str {
        match self {
            ArgKeys::Dir => "dir",
            ArgKeys::RequestId => "requestid",
            ArgKeys::Sleep => "sleep",
        }
    }
}

fn main() {
    let matches = Command::new("Task04 Resolver")
        .version("1.0.0")
        .arg(
            Arg::new(ArgKeys::Dir.as_str())
                .short('d')
                .long("dir")
                .takes_value(true)
                .required(true)
                .help("Directory with task04.exe"),
        )
        .arg(
            Arg::new(ArgKeys::Sleep.as_str())
                .short('s')
                .long("sleep")
                .takes_value(true)
                .required(true)
                .help("Sleep time (seconds)"),
        )
        .arg(
            Arg::new(ArgKeys::RequestId.as_str())
                .short('r')
                .long("requestid")
                .takes_value(true)
                .required(true)
                .help("Request ID"),
        )
        .get_matches();

    let data: AppData = AppData {
        dir: String::from(matches.value_of(ArgKeys::Dir.as_str()).unwrap()),
        sleep: matches
            .value_of(ArgKeys::Sleep.as_str())
            .unwrap()
            .parse::<u8>()
            .unwrap(),
        request_id: matches
            .value_of(ArgKeys::RequestId.as_str())
            .unwrap()
            .parse::<u8>()
            .unwrap(),
    };

    println!("0x{:08X}", data.prepare_key());
}
