use std::process::Command;

fn main() {
    let output = Command::new("wmic")
        .arg("path")
        .arg("win32_physicalmedia")
        .arg("get")
        .arg("SerialNumber")
        .output()
        .expect("ls command failed to start");


    let out = String::from_utf8_lossy(&output.stdout);
    let serial = out.lines().map(|s| s.trim()).collect::<Vec<&str>>();
    if serial.len() < 2 {
        panic!("Wrong");
    }
    let a = serial[1];

    println!("Hello, {}! f", a);
}
