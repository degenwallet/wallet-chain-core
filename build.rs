use std::path::PathBuf;
use std::collections::HashMap;
//use swift_bridge_build::{CreatePackageConfig, ApplePlatform};
extern crate swift_bridge_build;
use swift_bridge_build::{CreatePackageConfig, ApplePlatform};

fn main() {
    let out_dir = PathBuf::from("./generated");

    let bridges = vec!["src/lib.rs"];
    for path in &bridges {
        println!("cargo:rerun-if-changed={}", path);
    }

    swift_bridge_build::parse_bridges(bridges)
        .write_all_concatenated(out_dir, env!("CARGO_PKG_NAME"));

    // Create Swift Package
    swift_bridge_build::create_package(CreatePackageConfig {
        bridge_dir: PathBuf::from("./generated"),
        paths: HashMap::from([
            (ApplePlatform::IOS, "target/aarch64-apple-ios/debug/libwallet_chain_core.a".into()),
            (ApplePlatform::Simulator, "target/universal-ios/debug/libwallet_chain_core.a".into()),
            (ApplePlatform::MacOS, "target/universal-macos/debug/libwallet_chain_core.a".into()),
        ]),
        out_dir: PathBuf::from("swift/WalletChainCore"),
        package_name: String::from("WalletChainCore")
    });
}