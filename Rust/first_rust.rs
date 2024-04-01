rust
use std::io::{self, Write};
use std::process::Command;

fn main() {
    let _ = Command::new("cmd")
        .args(["/C", "start /B notepad && echo This is the power of Rust > CON"])
        .spawn();

    println!("Rust code executed successfully. Notepad opened with 'This is the power
of Rust'.");
}