use std::collections::HashMap;

#[swift_bridge::bridge]
mod ffi {
    #[swift_bridge(swift_repr = "struct")]
    struct MyIpAddress {
        origin: String,
    }
    extern "Rust" {
        
        fn hello_rust() -> String;
        //fn rust_result() -> Result<String, String>;
        async fn get_my_ip_from_rust() -> MyIpAddress;
    }

    enum Coin {
        Bitcoin = "Bitcoin",
        Ethereum = "Ethereum"
    }
}

fn hello_rust() -> String {
    String::from("Hello from Rust!")
}

async fn get_my_ip_from_rust() -> ffi::MyIpAddress {
    println!("Starting HTTP request from the Rust side...");

    let origin = reqwest::get("https://httpbin.org/ip")
        .await
        .unwrap()
        .json::<HashMap<String, String>>()
        .await
        .unwrap()
        .remove("origin")
        .unwrap();

    println!("HTTP request complete. Returning the value to Swift...");

    ffi::MyIpAddress { origin }
}

// fn rust_result() -> Result<String, String> {
//     return Ok(String::from("Rust string result"))
// }