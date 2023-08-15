import 'package:calculator/calculator.dart';
import 'package:test/test.dart';

void main() {
  test('calculator', () {
    expect(Calculator('10*5+4/2-1').calculate(), 51);
    expect(Calculator('(x*3-5)/5').calculate({'x': 10}), 5);
    expect(Calculator('3*x+15/(3+2)').calculate({'x': 10}), 33);
    expect(Calculator('a + 3 + 4 * 2 / (1 - 5) * 2').calculate({'a': 5}), 4);
    expect(Calculator('a + -3 + 4 * 2 / (1 - 5) * 2').calculate({'a': 5}), -2);
  });
}
