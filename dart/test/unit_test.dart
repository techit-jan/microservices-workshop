import 'package:test/test.dart';
import '../lib/unit_test.dart';

void main() {
  test('add success', () {
    expect(unit_test.add(1, 2), 3);
    expect(unit_test.add(-1, 1), 0);
    expect(unit_test.add(0, 0), 0);
  });

  test('add fail case', () {
    expect(unit_test.add(1, 2), isNot(-1));
  });

  test('badAdd fail (intentional)', () {
    expect(unit_test.badAdd(1, 2), 3); // ❌ FAIL
  });

  test('badAdd success', () {
    expect(unit_test.badAdd(1, 2), isNot(3)); // ✅ PASS
  });
}