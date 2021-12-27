# Rust guide

## General
* Rust comes with three tools: `rustup`, `rustc`, `cargo`.
  * `rustup`: Rustup installs The Rust Programming Language from the official
    release channels, enabling you to easily switch between stable,
    beta, and nightly compilers and keep them updated. It makes
    cross-compiling simpler with binary builds of the standard library
    for common platforms.
    * Common toolchain targets:
      * `aarch64-unknown-linux-gnu`
      * `x86_64-unknown-linux-gnu`
      * `aarch64-apple-darwin`
      * `x86_64-apple-darwin`
    * View all available installed and available targets with `rustup target list`
    * To add a target for cross-compilation: `rustup target add x86_64-apple-darwin`
    * View currently installed toolchains with `rustup toolchain list`
    * Install a toolchain with `rustup toolchain install stable-x86_64-pc-windows-msvc`
  * `rustc`: The Rust compiler. Rarely used on its own. More common to use `cargo` for compilation.
  * `cargo`: Rust package manager.
* A package is a `Cargo.toml` + source code.
* Cross compile by installing the `cross` tool (https://github.com/rust-embedded/cross), then: `cross build --release --target x86_64-apple-darwin`.

## Cargo
* `cargo build`
  * `cargo build` will build binaries in debug mode and place them in `target/debug/`
  * `cargo build --release` will build optimized binaries (takes longer to build but the binary will run faster) and place them in `target/release/`
  * Can add a dependency in your `Cargo.toml` and run `cargo build` to automatically download the dependency and include it in compilation.
* `cargo test`
  * 2 different types of tests with Rust:
    1. unit tests - tests located within your library or binary (usually in the `src/` dir). These tests have access to the lib/bin _private_ API and _public_ API.
    2. integration tests - tests usually located within a `tests/` dir. These tests only have access to the _public_ API.
 
