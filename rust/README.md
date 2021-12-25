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
    * View currently installed toolchains with `rustup toolchain list`
    * Install a toolchain with `rustup toolchain install stable-x86_64-pc-windows-msvc`
  * `rustc`: The Rust compiler. Rarely used on its own. More common to use `cargo` for compilation.
  * `cargo`: Rust package manager.
