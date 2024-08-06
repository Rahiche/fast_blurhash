@ffi.DefaultAsset('package:fast_blurhash/fast_blurhash')
library rust;

import 'dart:ffi' as ffi;

@ffi.Native<
    VecU8 Function(
        ffi.Pointer<ffi.Uint8>, ffi.Size, ffi.Uint32, ffi.Uint32, ffi.Float)>()
external VecU8 decode_blurhash(
  ffi.Pointer<ffi.Uint8> blurhash,
  int blurhash_len,
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
