import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_calculator/app.dart';
import 'package:flutter_calculator/app_config.dart';

String displayValue(WidgetTester tester) {
  return tester.widget<Text>(find.byKey(const Key('calculator_display'))).data!;
}

void main() {
  testWidgets('prod entry renders production label', (WidgetTester tester) async {
    await tester.pumpWidget(
      const CalculatorApp(
        config: AppConfig(
          environment: AppEnvironment.prod,
          appName: 'Flutter Calculator',
          apiBaseUrl: 'https://api.example.com',
        ),
      ),
    );

    expect(displayValue(tester), '0');
    expect(find.text('Production environment'), findsOneWidget);
  });
}
