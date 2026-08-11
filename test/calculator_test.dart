import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_calculator/app.dart';
import 'package:flutter_calculator/app_config.dart';

const devConfig = AppConfig(
  environment: AppEnvironment.dev,
  appName: 'Flutter Calculator Dev',
  apiBaseUrl: 'https://dev.example.com',
);

String displayValue(WidgetTester tester) {
  return tester.widget<Text>(find.byKey(const Key('calculator_display'))).data!;
}

void main() {
  group('Calculator UI Tests', () {
    testWidgets('shows 0 on start', (tester) async {
      await tester.pumpWidget(const CalculatorApp(config: devConfig));
      expect(displayValue(tester), '0');
    });

    testWidgets('tapping a digit updates display', (tester) async {
      await tester.pumpWidget(const CalculatorApp(config: devConfig));
      await tester.tap(find.text('7'));
      await tester.pump();
      expect(displayValue(tester), '7');
    });

    testWidgets('addition works correctly', (tester) async {
      await tester.pumpWidget(const CalculatorApp(config: devConfig));
      await tester.tap(find.text('3'));
      await tester.pump();
      await tester.tap(find.text('+'));
      await tester.pump();
      await tester.tap(find.text('4'));
      await tester.pump();
      await tester.tap(find.text('='));
      await tester.pump();
      expect(displayValue(tester), '7');
    });

    testWidgets('subtraction works correctly', (tester) async {
      await tester.pumpWidget(const CalculatorApp(config: devConfig));
      await tester.tap(find.text('9'));
      await tester.pump();
      await tester.tap(find.text('-'));
      await tester.pump();
      await tester.tap(find.text('3'));
      await tester.pump();
      await tester.tap(find.text('='));
      await tester.pump();
      expect(displayValue(tester), '6');
    });

    testWidgets('clear resets to 0', (tester) async {
      await tester.pumpWidget(const CalculatorApp(config: devConfig));
      await tester.tap(find.text('9'));
      await tester.pump();
      await tester.tap(find.text('C'));
      await tester.pump();
      expect(displayValue(tester), '0');
    });

    testWidgets('shows the selected environment', (tester) async {
      await tester.pumpWidget(const CalculatorApp(config: devConfig));
      expect(find.text('Development environment'), findsOneWidget);
    });
  });
}
