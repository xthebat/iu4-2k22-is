use std::io;
use std::io::ErrorKind;
use clap::Arg;

pub struct AppData {
    pub username: String,
}

pub enum ArgKeys {
    Username,
}

impl ArgKeys {
    fn as_str(&self) -> &'static str {
        match self {
            ArgKeys::Username => "username",
        }
    }
}

pub fn app_initial_parse() -> Result<AppData, io::Error> {
    let matches = clap::Command::new("Task06 Resolver")
        .version("1.0.0")
        .arg(
            Arg::new(ArgKeys::Username.as_str())
                .short('u')
                .long("username")
                .takes_value(true)
                .required(true)
                .help("Username")
        )
        .get_matches();

    let username: Result<&str, io::Error> = match matches.value_of(
        ArgKeys::Username.as_str()
    ) {
        None => Err(
            io::Error::new(
                ErrorKind::InvalidInput,
                "Username was not provided",
            )),
        Some(v) => Ok(v),
    };

    if username.is_err() {
        return Err(username.unwrap_err());
    }

    return Ok(AppData {
        username: username.unwrap_or("").to_string(),
    });
}