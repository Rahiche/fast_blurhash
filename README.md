# fast_blurhash

A Dart FFI package project that uses Rust to decode the blurhash and encode the final image, utilizing FFI to call these functions. This package exists because it works faster than the common Dart implementation and can be tested in release mode by running the `benchmarks.dart` demo. 

It only works with the latest version of Flutter on the main branch and requires the following feature to be enabled: `flutter config --enable-native-assets`. For more details, refer to [this issue](https://github.com/flutter/flutter/issues/129757).

## Project structure

This template uses the following structure:

* `rust`: Contains the rust source code. 

* `lib`: Contains the Dart code that defines the API of the plugin, and which calls into the native code using `dart:ffi`.



## Benchmarks

To test the performance of the package in release mode, run the `benchmarks.dart` demo.

#### So far I have tried this one iOS and macos release mode, don't run the benchmarks on debug mode.

Run the benchmark using : `flutter run -t lib/benchmarks.dart --release` 

<img width="912" alt="Screenshot 2024-08-06 at 22 47 17" src="https://github.com/user-attachments/assets/3a8c1dc9-0a95-4570-a8d4-40ae5bf2d5f7">

