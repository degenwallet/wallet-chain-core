LIB_NAME=libwallet_chain_core
 
bootstrap: install-dependency add-target build

build:
	./build-rust.sh

add-target:
	rustup target add x86_64-apple-darwin aarch64-apple-darwin aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim

install-dependency:
	cargo install -f swift-bridge-cli