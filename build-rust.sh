#!/bin/bash

set -e
LIB_NAME="libwallet_chain_core"
THISDIR=$(dirname $0)
cd $THISDIR

# Build the project for the desired platforms:
cargo build --target x86_64-apple-darwin
cargo build --target aarch64-apple-darwin
mkdir -p ./target/universal-macos/debug

lipo \
    ./target/aarch64-apple-darwin/debug/$LIB_NAME.a \
    ./target/x86_64-apple-darwin/debug/$LIB_NAME.a -create -output \
    ./target/universal-macos/debug/$LIB_NAME.a

cargo build --target aarch64-apple-ios

cargo build --target x86_64-apple-ios
cargo build --target aarch64-apple-ios-sim
mkdir -p ./target/universal-ios/debug

lipo \
    ./target/aarch64-apple-ios-sim/debug/$LIB_NAME.a \
    ./target/x86_64-apple-ios/debug/$LIB_NAME.a -create -output \
    ./target/universal-ios/debug/$LIB_NAME.a
