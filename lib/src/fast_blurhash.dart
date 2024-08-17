import 'dart:collection';
import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'dart:isolate';
import 'package:ffi/ffi.dart' as ffi_pacakge;
import 'ffi_rust.dart' as ffi_rust;

/// This function serves as a warm-up for the decodeBlurhash function.
/// The initial call to decodeBlurhash can be slow, so this function should be called
/// anywhere in the code before using decodeBlurhash to improve performance.
void setup() {
  // TODO: check if there is another way to warmup and avoid the cost of the first call
  decodeBlurhash(
    blurhashString: "THEC,t~qWGb=IUxI%ejEIBR~xuaf",
    height: 1,
    width: 1,
    punch: 1,
  );
}

/// Decodes a BlurHash string into image data.
/// - `blurhashString`: The BlurHash string to decode.
/// - `height`: Height of the resulting image.
/// - `width`: Width of the resulting image.
/// - `punch`: Contrast adjustment factor.
/// - `enableCache`: Whether to enable caching (default: `true`).
Uint8List decodeBlurhash({
  required String blurhashString,
  int height = 32,
  int width = 32,
  double punch = 1.0,
  bool enableCache = true,
}) {
  // Check if the result is already in the cache
  final cacheKey = '$blurhashString-$height-$width-$punch';
  if (enableCache) {
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }
  }

  final blurhashLen = blurhashString.length;

  // Allocate memory for the blurhash string
  final blurhashPointer = ffi_pacakge.calloc<ffi.Uint8>(blurhashLen);
  final blurhashBytes = blurhashPointer.asTypedList(blurhashLen);
  for (int i = 0; i < blurhashLen; i++) {
    blurhashBytes[i] = blurhashString.codeUnitAt(i);
  }

  try {
    final result = ffi_rust.decodeBlurhash(
      blurhashPointer,
      blurhashLen,
      width,
      height,
      punch,
    );

    final int length = result.len;
    final ffi.Pointer<ffi.Uint8> dataPtr = result.ptr;
    final Uint8List data = dataPtr.asTypedList(length);

    // Cache the result
    _cache[cacheKey] = data;

    return data;
  } catch (e) {
    throw Exception('Failed to decode blurhash: $e');
  } finally {
    ffi_pacakge.calloc.free(blurhashPointer);
  }
}

/// Runs the decodeBlurhash function in a separate isolate.
/// Parameters are the same as decodeBlurhash.
Future<Uint8List> decodeBlurhashIsolate({
  required String blurhashString,
  int height = 32,
  int width = 32,
  double punch = 1.0,
  bool enableCache = true,
}) async {
  return await Isolate.run(
    () => decodeBlurhash(
      blurhashString: blurhashString,
      height: height,
      width: width,
      punch: punch,
      enableCache: enableCache,
    ),
  );
}

final Map<String, Uint8List> _cache = HashMap();
