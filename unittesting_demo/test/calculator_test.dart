import 'package:flutter_test/flutter_test.dart';

import 'calculator.dart';

void main() {
  //Gruop testing
  group('I want to test my calculator ', () {
    test('I want to test multiplication', () {
      //Step 1
      Calculator calc = Calculator();

      //Step 2

      int result = calc.mul(3, 2);

      //Step 3

      expect(result, 6);

      expect(result, isNot(9));
    });

    test('I want to test addition ', () {
      Calculator calc = Calculator();

      int result = calc.add(3, 2);

      expect(result, 5);
    });
  });
}
