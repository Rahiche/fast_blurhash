@ffi.DefaultAsset('package:fast_blurhash/fast_blurhash')
library rust;

import 'dart:ffi' as ffi;

/// This function serves as an interface to a native Rust implementation of the Blurhash decoding algorithm.
/// - `blurhash`: A pointer to the Blurhash string to decode.
/// - `length`: The length of the Blurhash string.
/// - `width`: The width of the resulting image.
/// - `height`: The height of the resulting image.
/// - `punch`: A parameter to adjust the contrast of the resulting image. Higher values will increase the contrast.
@ffi.Native<
    VecU8 Function(
        ffi.Pointer<ffi.Uint8>, ffi.Size, ffi.Uint32, ffi.Uint32, ffi.Float)>(isLeaf: true)
external VecU8 decodeBlurhash(
  ffi.Pointer<ffi.Uint8> blurhash,
  int length,
  int width,
  int height,
  double punch,
);

final class VecU8 extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Size()
  external int len;

  @ffi.Size()
  external int cap;
}
