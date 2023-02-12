LIB_NAME=libwallet_chain_core
 
bootstrap: install-dependency add-target build create-package

build:
	./build-rust.sh

add-target:
	rustup target add x86_64-apple-darwin aarch64-apple-darwin aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim

install-dependency:
	cargo install -f swift-bridge-cli

create-package:
	swift-bridge-cli create-package \
  		--bridges-dir ./generated \
  		--out-dir swift/WalletChainCore \
  		--ios target/aarch64-apple-ios/debug/$(LIB_NAME).a \
  		--simulator target/universal-ios/debug/$(LIB_NAME).a \
  		--macos target/universal-macos/debug/$(LIB_NAME).a \
 		--name WalletChainCore