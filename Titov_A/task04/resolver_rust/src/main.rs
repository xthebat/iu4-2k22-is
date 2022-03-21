extern crate core;

use clap::Arg;
use std::panic;

trait PathTrait {
    fn calc_path_chksum(&self) -> u16;
}

// Аналог Kotlin'овских Extension'ов
impl PathTrait for String {
    /**
     * Генерация checksum по строке
     */
    fn calc_path_chksum(&self) -> u16 {
        // Я бы переписал в функциональном стиле
        let mut sum = 0u16;
        for ch in self.chars() {
            sum += ch as u16;
        }

        sum
    }
}

#[derive(Debug)]
struct AppData {
    path: String,
    sleep: u8,
    request_id: u8,
}

impl AppData {
    /**
     * Доп. Валидация входных данных
     */
    pub fn validate(&self) -> Result<(), String> {
        let sleep_range = 1u8..0x10u8;
        if !((sleep_range).contains(&self.sleep)) {
            return Err(format!("Sleep is not in range {:?}", sleep_range));
        }

        let request_id_range = 1u8..0x7u8;
        if !((request_id_range).contains(&self.request_id)) {
            return Err(format!("Request ID is not in range {:?}", request_id_range));
        }

        return Ok(());
    }

    /**
     * Основная логика ради которой все это затевалось
     */
    pub fn prepare_key(&self) -> u32 {
        let sleep_result = 0x10 - (self.sleep & 0xF);
        ((sleep_result as u32 & 0xF) << 0x18)
            | ((0xD) << 0x14)
            | ((self.path.calc_path_chksum() as u32 & 0xFFFF) << 4)
            | (self.request_id as u32 & 0xF)
    }
}

enum ArgKeys {
    Path,
    RequestId,
    Sleep,
}

impl ArgKeys {
    fn as_str(&self) -> &'static str {
        match self {
            ArgKeys::Path => "path",
            ArgKeys::RequestId => "requestid",
            ArgKeys::Sleep => "sleep",
        }
    }
}

fn main() {
    let matches = clap::Command::new("Task04 Resolver")
        .version("1.0.0")
        .arg(
            Arg::new(ArgKeys::Path.as_str())
                .short('p')
                .long("path")
                .takes_value(true)
                .required(true)
                .help("Path to task04.exe"),
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
        path: String::from(matches.value_of(ArgKeys::Path.as_str()).unwrap()),
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

    match data.validate() {
        Ok(_) => {}
        Err(err) => panic!("Validation error: {}", err),
    }

    let key = data.prepare_key();
    println!("Key: 0x{:08X}", key);

    let key_arg = (key as i32).to_string();
    println!(
        "Execute this:\n\x1b[36m{}\x1b[0m \x1b[35m{}\x1b[0m",
        &data.path, key_arg
    );
}
