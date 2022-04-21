mod resolver;
mod app;

use std::borrow::{Borrow, Cow};
use std::error::Error as ErrorError;
use std::io::Error;
use crate::resolver::Serial;
use crate::resolver::VecString;
use crate::app::{app_initial_parse, AppData};

trait KeyDecipher {
    fn byte_decipher(&self, salt: u32) -> String;
    fn padding(&self, size: usize) -> String;
}

impl KeyDecipher for String {
    fn byte_decipher(&self, salt: u32) -> String {
        self.as_bytes()
            .iter()
            .map(|c| (((*c as u32) ^ salt) % 25) as u8 + ('a' as u8))
            .collect::<Vec<u8>>()
            .to_str_utf8_lossy()
            .to_string()
    }

    fn padding(&self, size: usize) -> String {
        let mut str = String::with_capacity(size);
        for i in 0..size {
            str.push(match self.len() > i {
                true => self.as_bytes()[i] as char,
                false => '\0'
            });
        }

        str
    }
}


fn main() {
    let app_data = match app_initial_parse() {
        Ok(data) => data,
        Err(e) => panic!("{}", e.description())
    };
    println!("Username: {}", app_data.username);

    let serial = match Serial::get_serial_code() {
        Ok(s) => s,
        Err(e) => panic!("{}", e.description())
    };
    println!("Serial: 0x{serial:08X}");

    let result = app_data.username
        .to_string()
        .padding(0x8)
        .byte_decipher(serial)
        .to_string();
    println!("Password: {result}")
}

