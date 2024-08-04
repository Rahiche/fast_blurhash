import 'package:test/test.dart';

import 'package:fast_blurhash/fast_blurhash.dart';

void main() {
  test('invoke native function', () {
    // Tests are run in debug mode.
    expect(sum(24, 18), 1042);
  });

  test('invoke async native callback', () async {
    expect(await sumAsync(24, 18), 42);
  });
}
