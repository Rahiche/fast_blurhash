import 'package:fast_blurhash/fast_blurhash.dart';
import 'package:test/test.dart';
import 'dart:typed_data';

void main() {
  group('decodeBlurhash', () {
    test('returns correct Uint8List for valid inputs', () {
      // Define your valid inputs and expected output
      String blurhashString = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';
      int height = 32;
      int width = 32;
      double punch = 1.0;

      // Call the function
      Uint8List result = decodeBlurhash(
        blurhashString: blurhashString,
        height: height,
        width: width,
        punch: punch,
      );

      // Define your expected result
      Uint8List expected = Uint8List.fromList([
        137,
        80,
        78,
        71,
        13,
        10,
        26,
        10,
        0,
        0,
        0,
        13,
        73,
        72,
        68,
        82,
        0,
        0,
        0,
        32,
        0,
        0,
        0,
        32,
        8,
        6,
        0,
        0,
        0,
        115,
        122,
        122,
        244,
        0,
        0,
        5,
        251,
        73,
        68,
        65,
        84,
        120,
        1,
        237,
        224,
        1,
        144,
        36,
        73,
        146,
        36,
        73,
        18,
        139,
        170,
        153,
        187,
        71,
        68,
        68,
        102,
        102,
        102,
        86,
        85,
        85,
        85,
        85,
        119,
        119,
        119,
        119,
        119,
        247,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        204,
        116,
        119,
        119,
        119,
        119,
        87,
        87,
        85,
        85,
        85,
        85,
        102,
        102,
        70,
        70,
        68,
        132,
        187,
        155,
        153,
        10,
        207,
        76,
        102,
        87,
        119,
        117,
        119,
        119,
        79,
        207,
        204,
        204,
        204,
        204,
        76,
        98,
        253,
        162,
        239,
        255,
        89,
        11,
        8,
        65,
        8,
        170,
        160,
        10,
        186,
        128,
        26,
        166,
        19,
        212,
        128,
        42,
        83,
        3,
        138,
        76,
        200,
        4,
        70,
        0,
        24,
        3,
        182,
        73,
        67,
        179,
        104,
        134,
        201,
        98,
        178,
        152,
        82,
        76,
        22,
        147,
        197,
        100,
        49,
        57,
        104,
        134,
        180,
        72,
        68,
        240,
        76,
        230,
        57,
        25,
        243,
        108,
        6,
        0,
        27,
        108,
        48,
        151,
        25,
        3,
        128,
        205,
        179,
        153,
        43,
        12,
        54,
        207,
        203,
        60,
        0,
        21,
        140,
        1,
        153,
        203,
        12,
        88,
        128,
        1,
        131,
        49,
        24,
        192,
        24,
        99,
        140,
        1,
        99,
        132,
        49,
        198,
        6,
        3,
        54,
        216,
        96,
        3,
        22,
        151,
        217,
        216,
        96,
        11,
        27,
        48,
        96,
        48,
        0,
        166,
        218,
        32,
        192,
        2,
        243,
        76,
        54,
        6,
        108,
        48,
        198,
        105,
        28,
        96,
        140,
        49,
        182,
        177,
        12,
        24,
        0,
        99,
        108,
        176,
        193,
        8,
        219,
        56,
        133,
        29,
        216,
        128,
        193,
        54,
        24,
        108,
        97,
        0,
        3,
        64,
        53,
        0,
        6,
        131,
        1,
        3,
        198,
        24,
        112,
        26,
        203,
        88,
        96,
        27,
        43,
        177,
        140,
        101,
        140,
        185,
        194,
        24,
        48,
        96,
        131,
        13,
        70,
        216,
        129,
        157,
        216,
        129,
        13,
        216,
        216,
        96,
        12,
        6,
        3,
        182,
        168,
        182,
        185,
        159,
        49,
        105,
        176,
        140,
        101,
        82,
        198,
        50,
        41,
        147,
        50,
        129,
        73,
        37,
        146,
        73,
        140,
        48,
        0,
        198,
        24,
        72,
        11,
        35,
        108,
        145,
        54,
        73,
        144,
        134,
        116,
        144,
        24,
        27,
        108,
        99,
        174,
        176,
        161,
        218,
        198,
        64,
        0,
        182,
        177,
        32,
        109,
        44,
        99,
        37,
        137,
        177,
        140,
        149,
        36,
        70,
        74,
        18,
        35,
        18,
        97,
        0,
        12,
        24,
        72,
        32,
        17,
        233,
        32,
        9,
        108,
        48,
        96,
        131,
        1,
        59,
        48,
        198,
        128,
        17,
        182,
        169,
        105,
        35,
        192,
        64,
        98,
        194,
        198,
        152,
        148,
        73,
        18,
        147,
        164,
        76,
        146,
        136,
        68,
        36,
        40,
        17,
        70,
        24,
        48,
        6,
        12,
        36,
        34,
        9,
        146,
        196,
        4,
        73,
        33,
        109,
        18,
        48,
        144,
        8,
        219,
        24,
        48,
        198,
        64,
        117,
        26,
        128,
        196,
        8,
        72,
        76,
        146,
        36,
        137,
        49,
        73,
        35,
        73,
        146,
        68,
        36,
        34,
        129,
        68,
        36,
        194,
        32,
        99,
        192,
        136,
        68,
        36,
        34,
        41,
        164,
        76,
        2,
        9,
        24,
        145,
        8,
        147,
        24,
        72,
        2,
        99,
        140,
        168,
        182,
        49,
        16,
        152,
        196,
        132,
        77,
        146,
        216,
        73,
        146,
        36,
        141,
        116,
        146,
        52,
        68,
        67,
        78,
        32,
        17,
        137,
        48,
        200,
        24,
        48,
        34,
        37,
        146,
        32,
        101,
        146,
        32,
        5,
        6,
        18,
        176,
        68,
        2,
        70,
        24,
        147,
        24,
        3,
        53,
        109,
        4,
        164,
        141,
        48,
        233,
        36,
        72,
        210,
        73,
        186,
        145,
        110,
        164,
        27,
        73,
        67,
        110,
        64,
        195,
        78,
        130,
        4,
        18,
        196,
        101,
        22,
        36,
        65,
        83,
        144,
        74,
        82,
        149,
        4,
        82,
        96,
        137,
        164,
        97,
        137,
        36,
        49,
        194,
        74,
        140,
        168,
        206,
        196,
        64,
        96,
        210,
        70,
        78,
        210,
        73,
        186,
        145,
        110,
        164,
        27,
        153,
        19,
        233,
        134,
        60,
        1,
        13,
        220,
        128,
        4,
        18,
        196,
        101,
        41,
        97,
        5,
        86,
        33,
        101,
        82,
        96,
        65,
        74,
        164,
        132,
        37,
        172,
        196,
        8,
        43,
        177,
        3,
        3,
        213,
        54,
        0,
        182,
        49,
        137,
        51,
        177,
        19,
        103,
        98,
        55,
        156,
        19,
        118,
        35,
        115,
        66,
        158,
        144,
        39,
        146,
        6,
        110,
        32,
        3,
        6,
        129,
        21,
        164,
        130,
        84,
        146,
        97,
        82,
        144,
        18,
        14,
        97,
        5,
        86,
        98,
        37,
        150,
        176,
        133,
        49,
        22,
        84,
        219,
        128,
        177,
        141,
        109,
        236,
        196,
        153,
        100,
        54,
        50,
        27,
        153,
        141,
        204,
        137,
        200,
        137,
        244,
        136,
        60,
        17,
        110,
        36,
        13,
        145,
        32,
        176,
        192,
        10,
        172,
        32,
        195,
        56,
        193,
        33,
        28,
        194,
        22,
        142,
        192,
        10,
        172,
        196,
        18,
        70,
        88,
        128,
        69,
        117,
        38,
        0,
        198,
        56,
        19,
        59,
        113,
        54,
        156,
        137,
        51,
        113,
        107,
        56,
        27,
        153,
        19,
        242,
        132,
        115,
        194,
        158,
        128,
        6,
        36,
        200,
        88,
        194,
        10,
        50,
        10,
        54,
        56,
        192,
        22,
        182,
        112,
        20,
        76,
        98,
        37,
        86,
        98,
        9,
        75,
        96,
        97,
        65,
        197,
        6,
        140,
        109,
        112,
        66,
        26,
        103,
        66,
        38,
        100,
        195,
        153,
        56,
        27,
        110,
        19,
        246,
        132,
        115,
        194,
        158,
        128,
        6,
        36,
        200,
        88,
        96,
        5,
        216,
        96,
        176,
        5,
        17,
        64,
        1,
        26,
        80,
        176,
        18,
        34,
        129,
        0,
        27,
        43,
        177,
        69,
        197,
        201,
        101,
        54,
        216,
        216,
        9,
        54,
        118,
        226,
        76,
        200,
        134,
        179,
        65,
        38,
        184,
        225,
        108,
        216,
        19,
        208,
        128,
        4,
        25,
        36,
        144,
        185,
        66,
        160,
        0,
        7,
        184,
        129,
        11,
        206,
        6,
        81,
        112,
        38,
        40,
        65,
        2,
        0,
        130,
        138,
        13,
        24,
        108,
        112,
        130,
        19,
        156,
        144,
        9,
        78,
        112,
        130,
        19,
        220,
        32,
        19,
        220,
        192,
        9,
        52,
        32,
        17,
        198,
        8,
        48,
        88,
        224,
        134,
        92,
        192,
        9,
        78,
        112,
        34,
        140,
        156,
        136,
        4,
        18,
        16,
        32,
        32,
        169,
        56,
        17,
        32,
        27,
        108,
        100,
        131,
        19,
        72,
        112,
        2,
        9,
        78,
        32,
        129,
        4,
        18,
        72,
        228,
        68,
        74,
        176,
        145,
        4,
        0,
        36,
        194,
        200,
        137,
        108,
        100,
        35,
        39,
        40,
        193,
        9,
        24,
        48,
        96,
        32,
        1,
        81,
        133,
        193,
        70,
        24,
        57,
        129,
        68,
        24,
        217,
        8,
        3,
        70,
        24,
        48,
        200,
        200,
        70,
        24,
        201,
        72,
        6,
        0,
        25,
        4,
        200,
        72,
        70,
        50,
        146,
        17,
        137,
        48,
        178,
        145,
        140,
        72,
        68,
        130,
        5,
        0,
        4,
        85,
        78,
        4,
        200,
        70,
        24,
        97,
        192,
        72,
        6,
        140,
        48,
        146,
        145,
        64,
        128,
        2,
        100,
        16,
        66,
        8,
        201,
        88,
        66,
        1,
        22,
        32,
        176,
        32,
        48,
        41,
        16,
        38,
        100,
        146,
        68,
        54,
        144,
        72,
        66,
        22,
        144,
        84,
        97,
        100,
        16,
        70,
        24,
        217,
        4,
        70,
        24,
        9,
        36,
        80,
        128,
        0,
        25,
        100,
        17,
        22,
        66,
        132,
        4,
        2,
        73,
        32,
        145,
        18,
        17,
        96,
        129,
        3,
        66,
        198,
        130,
        196,
        8,
        35,
        140,
        48,
        178,
        65,
        9,
        136,
        26,
        54,
        96,
        132,
        17,
        38,
        100,
        100,
        35,
        153,
        144,
        81,
        128,
        18,
        34,
        32,
        44,
        2,
        33,
        139,
        144,
        16,
        129,
        100,
        144,
        64,
        66,
        18,
        41,
        97,
        9,
        11,
        44,
        72,
        153,
        144,
        9,
        76,
        42,
        17,
        1,
        36,
        50,
        64,
        80,
        133,
        17,
        70,
        152,
        192,
        8,
        35,
        153,
        0,
        20,
        16,
        9,
        10,
        33,
        132,
        44,
        132,
        8,
        130,
        0,
        68,
        34,
        25,
        36,
        80,
        96,
        5,
        40,
        0,
        129,
        132,
        37,
        2,
        72,
        129,
        0,
        97,
        132,
        17,
        70,
        24,
        147,
        212,
        192,
        128,
        17,
        70,
        152,
        16,
        4,
        32,
        32,
        0,
        133,
        8,
        68,
        56,
        8,
        130,
        32,
        8,
        76,
        8,
        132,
        144,
        140,
        16,
        150,
        176,
        2,
        8,
        144,
        48,
        34,
        128,
        16,
        4,
        16,
        54,
        1,
        4,
        73,
        34,
        68,
        34,
        68,
        21,
        70,
        24,
        1,
        129,
        17,
        70,
        2,
        1,
        146,
        8,
        131,
        16,
        66,
        4,
        65,
        80,
        8,
        65,
        32,
        36,
        35,
        140,
        36,
        140,
        176,
        2,
        8,
        32,
        48,
        34,
        16,
        129,
        8,
        140,
        0,
        97,
        100,
        16,
        70,
        128,
        12,
        53,
        48,
        0,
        194,
        72,
        32,
        64,
        64,
        0,
        2,
        36,
        17,
        136,
        80,
        32,
        140,
        48,
        146,
        9,
        132,
        148,
        72,
        32,
        192,
        8,
        43,
        16,
        1,
        8,
        59,
        8,
        68,
        24,
        132,
        8,
        64,
        54,
        146,
        145,
        13,
        128,
        128,
        42,
        140,
        0,
        97,
        132,
        9,
        76,
        96,
        20,
        16,
        8,
        33,
        36,
        33,
        68,
        72,
        4,
        65,
        8,
        164,
        36,
        16,
        18,
        8,
        48,
        194,
        136,
        68,
        4,
        129,
        45,
        2,
        17,
        22,
        97,
        16,
        70,
        128,
        108,
        132,
        17,
        96,
        160,
        10,
        16,
        70,
        128,
        0,
        9,
        4,
        72,
        32,
        32,
        4,
        66,
        72,
        66,
        10,
        36,
        16,
        16,
        130,
        144,
        17,
        128,
        64,
        8,
        35,
        112,
        0,
        34,
        45,
        100,
        16,
        32,
        64,
        128,
        12,
        194,
        8,
        35,
        64,
        64,
        21,
        70,
        128,
        48,
        146,
        17,
        32,
        129,
        0,
        9,
        144,
        144,
        132,
        36,
        36,
        33,
        9,
        41,
        16,
        32,
        25,
        1,
        18,
        24,
        129,
        133,
        20,
        200,
        65,
        32,
        2,
        33,
        132,
        0,
        25,
        36,
        35,
        132,
        48,
        88,
        128,
        169,
        226,
        153,
        4,
        2,
        16,
        151,
        73,
        2,
        9,
        73,
        72,
        32,
        9,
        73,
        72,
        66,
        2,
        41,
        144,
        140,
        48,
        66,
        0,
        32,
        33,
        11,
        113,
        63,
        33,
        64,
        6,
        9,
        100,
        158,
        69,
        24,
        33,
        42,
        128,
        48,
        226,
        10,
        1,
        18,
        151,
        9,
        144,
        0,
        9,
        36,
        144,
        144,
        132,
        4,
        200,
        32,
        33,
        174,
        16,
        2,
        132,
        0,
        16,
        66,
        8,
        192,
        188,
        16,
        230,
        31,
        1,
        144,
        167,
        115,
        154,
        83,
        29,
        13,
        10,
        0,
        0,
        0,
        0,
        73,
        69,
        78,
        68,
        174,
        66,
        96,
        130
      ]);

      // Check if the result matches the expected value
      expect(result, expected);
    });

    test('returns an empty Uint8List for height or width of zero', () {
      String blurhashString = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';
      int height = 0;
      int width = 32;
      double punch = 1.0;

      // Call the function with height 0
      Uint8List resultHeightZero = decodeBlurhash(
        blurhashString: blurhashString,
        height: height,
        width: width,
        punch: punch,
      );

      expect(resultHeightZero, isEmpty);

      // Call the function with width 0
      Uint8List resultWidthZero = decodeBlurhash(
        blurhashString: blurhashString,
        height: 32,
        width: 0,
        punch: punch,
      );

      expect(resultWidthZero, isEmpty);
    });

    test('returns a non-empty Uint8List for valid inputs', () {
      String blurhashString = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';
      int height = 32;
      int width = 32;
      double punch = 1.0;

      // Call the function
      Uint8List result = decodeBlurhash(
        blurhashString: blurhashString,
        height: height,
        width: width,
        punch: punch,
      );

      // Check if the result is not empty
      expect(result, isNotEmpty);
    });


     test('returns an empty Uint8List invlaid hash', () {
      String blurhashString = 'invalid hash';
      int height = 0;
      int width = 32;
      double punch = 1.0;

      // Call the function with height 0
      Uint8List resultHeightZero = decodeBlurhash(
        blurhashString: blurhashString,
        height: height,
        width: width,
        punch: punch,
      );

      expect(resultHeightZero, isEmpty);

      // Call the function with width 0
      Uint8List resultWidthZero = decodeBlurhash(
        blurhashString: blurhashString,
        height: 32,
        width: 0,
        punch: punch,
      );

      expect(resultWidthZero, isEmpty);
    });

  });
}
