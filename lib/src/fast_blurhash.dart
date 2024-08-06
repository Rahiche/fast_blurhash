import 'dart:collection';
import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi_pacakge;

import 'ffi_rust.dart' as ffi_rust;

// TODO: check if there is another way to warmup and avoid the cost of the first call
void setup() {
  Future.value(() {
    return decodeBlurhash(
      blurhashString: "THEC,t~qWGb=IUxI%ejEIBR~xuaf",
      height: 10,
      width: 10,
      punch: 1,
    );
  });
}

final Map<String, Uint8List> _cache = HashMap();

Uint8List decodeBlurhash({
  required String blurhashString,
  required int height,
  required int width,
  required double punch,
}) {
  // Check if the result is already in the cache
  final cacheKey = '$blurhashString-$height-$width-$punch';
  if (_cache.containsKey(cacheKey)) {
    return _cache[cacheKey]!;
  }

  try {
    final blurhashLen = blurhashString.length;

    // Allocate memory for the blurhash string
    final blurhashPointer = ffi_pacakge.calloc<ffi.Uint8>(blurhashLen);
    final blurhashBytes = blurhashPointer.asTypedList(blurhashLen);
    for (int i = 0; i < blurhashLen; i++) {
      blurhashBytes[i] = blurhashString.codeUnitAt(i);
    }

    final result = ffi_rust.decode_blurhash(
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
  }
  //  finally {
  // ffi_pacakge.calloc.free(blurhashPointer);
  // }
}
