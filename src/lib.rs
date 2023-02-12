#[swift_bridge::bridge]
mod ffi {
    extern "Rust" {
        fn hello_rust() -> String;
    }

    enum Coin {
        Bitcoin = "Bitcoin",
        Ethereum = "Ethereum"
    }
}

fn hello_rust() -> String {
    String::from("Hello from Rust!")
}
