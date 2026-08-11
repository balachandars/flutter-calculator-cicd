import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_calculator/main.dart';

void main() {
  group('Calculator UI Tests', () {
    testWidgets('shows 0 on start', (tester) async {
      await tester.pumpWidget(const CalculatorApp());
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('tapping a digit updates display', (tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.text('7'));
      await tester.pump();
      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('addition works correctly', (tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.text('3'));
      await tester.pump();
      await tester.tap(find.text('+'));
      await tester.pump();
      await tester.tap(find.text('4'));
      await tester.pump();
      await tester.tap(find.text('='));
      await tester.pump();
      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('subtraction works correctly', (tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.text('9'));
      await tester.pump();
      await tester.tap(find.text('-'));
      await tester.pump();
      await tester.tap(find.text('3'));
      await tester.pump();
      await tester.tap(find.text('='));
      await tester.pump();
      expect(find.text('6'), findsOneWidget);
    });

    testWidgets('clear resets to 0', (tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.text('9'));
      await tester.pump();
      await tester.tap(find.text('C'));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });
  });
}
