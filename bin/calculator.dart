import 'package:calculator/calculator.dart' as calculator;

void main(List<String> arguments) {
  final calc = calculator.Calculator('a + -3 + 4 * 2 / (1 - 5) * 2');
  print(calc.calculate({'a': 5}));
}
