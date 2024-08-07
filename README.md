# fast_blurhash

A Dart FFI package project that uses Rust to decode the blurhash and encode the final image, utilizing FFI to call these functions. This package exists because it works faster than the common Dart implementation and can be tested in release mode by running the `benchmarks.dart` demo. 

It only works with the latest version of Flutter on the main branch and requires the following feature to be enabled: `flutter config --enable-native-assets`. For more details, refer to [this issue](https://github.com/flutter/flutter/issues/129757).

## Status

- Uses experimental APIs which might change in the future.
- The first time call takes longer than the average time so I have added a setup function to do a warmup call.
- Tested only on iOS and MacOs in release mode.
- Significant performance difference between release mode and debug mode; do not rely on debug mode results.

## Project structure

This template uses the following structure:

* `rust`: Contains the rust source code. 

* `lib`: Contains the Dart code that defines the API of the plugin, and which calls into the native code using `dart:ffi`.


## Benchmarks

To test the performance of the package in release mode, run the `benchmarks.dart` demo.

#### So far I have tried this one iOS and macos release mode, don't run the benchmarks on debug mode.

Run the benchmark using : `flutter run -t lib/benchmarks.dart --release` 


### iPhone 15 pro:
<img src="https://i.imgur.com/qpfqNvj.png" alt="screenshot from the benchmarks demo on iPhone 15 pro" width="589.5" />

### M1 Macbook Pro  
<img src="https://i.imgur.com/Bv3frB3.png" alt="screenshot from the benchmarks demo on macbook pro" width="912" />

