use std::io;
use std::io::ErrorKind;
use std::process::Command;

pub trait VecString {
    fn to_str_utf8_lossy(&self) -> std::borrow::Cow<str>;
}

impl VecString for Vec<u8> {
    fn to_str_utf8_lossy(&self) -> std::borrow::Cow<str> {
        return String::from_utf8_lossy(&self);
    }
}

pub struct Serial {}

impl Serial {
    fn __get_serial_key_str() -> Result<String, io::Error> {
        match Command::new("wmic")
            .arg("path")
            .arg("win32_physicalmedia")
            .arg("get")
            .arg("SerialNumber")
            .output() {
            Ok(v) => match v.stdout
                .to_str_utf8_lossy()
                .lines()
                .nth(1) {
                None => Err(io::Error::new(
                    ErrorKind::UnexpectedEof,
                    "Cannot resolve",
                )),
                Some(v) => Ok(v.to_string())
            }
            Err(e) => Err(e)
        }
    }

    /**
     * Uses device serial ID to calculate key XOR salt
     */
    pub fn get_serial_code() -> Result<u32, io::Error> {
        match Serial::__get_serial_key_str() {
            Ok(str) => {
                str.as_bytes()
                    .iter()
                    .try_fold(
                        0u32,
                        |a, b| Ok(a + (*b as u32))
                    )
            }
            Err(e) => Err(e)
        }
    }
}
