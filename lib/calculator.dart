class Calculator {
  String expression;
  List<String>? _postfixExpression;
  final _priorities = {'+': 0, '-': 0, '*': 1, '/': 1, '(': -1, ')': -1};

  Calculator(this.expression) {
    _postfixExpression = _postfixNotation();
  }

  double calculate([Map<String, double>? numbers]) {
    numbers?.forEach((name, value) {
      _postfixExpression = _postfixExpression
          ?.map<String>((e) => name == e ? value.toString() : e)
          .toList();
    });

    if (_postfixExpression == null) {
      return 0;
    }

    var numStack = <double>[];
    for (var element in _postfixExpression!) {
      var doubleValue = double.tryParse(element);
      if (doubleValue != null) {
        numStack.add(doubleValue);
        continue;
      }

      final secondValue = numStack.removeLast();
      final firstValue = numStack.removeLast();

      switch (element) {
        case '-':
          numStack.add(firstValue - secondValue);
          break;
        case '+':
          numStack.add(firstValue + secondValue);
          break;
        case '*':
          numStack.add(firstValue * secondValue);
          break;
        case '/':
          numStack.add(firstValue / secondValue);
          break;
      }
    }

    return numStack.removeLast();
  }

  List<String> _postfixNotation() {
    var stack = <String>[];
    var output = <String>[];
    var currentNum = '';
    var re = RegExp(r'[A-z]');
    var isPrevNum = false;
    var isUnaryMinus = false;

    var chars =
        expression.split('').where((element) => element != ' ').toList();

    for (var element in chars) {
      if (num.tryParse(element) != null ||
          element == ',' ||
          re.hasMatch(element)) {
        currentNum += element;
        isPrevNum = true;
        continue;
      }

      // добавление текущего числа
      if (currentNum != '') {
        output.add(currentNum);
        currentNum = '';
      }

      // унарный минус
      if (!isPrevNum && element == '-') {
        isUnaryMinus = true;
        continue;
      }
      if (isUnaryMinus == true) {
        output.addAll(['-1', '*']);
        isUnaryMinus = false;
      }

      isPrevNum = false;

      final operatorPriority = _priorities[element];
      if (operatorPriority == null) {
        throw 'Syntax error';
      }

      //обработка скобок
      if (element == '(') {
        stack.add(element);
        continue;
      } else if (element == ')') {
        while (stack.last != '(') {
          output.add(stack.removeLast());
        }
        stack.removeLast();
        continue;
      }

      while (stack.isNotEmpty && _priorities[stack.last]! >= operatorPriority) {
        output.add(stack.removeLast());
      }

      stack.add(element);
    }

    if (currentNum != '') {
      output.add(currentNum);
    }

    return [...output, ...stack.reversed];
  }
}
