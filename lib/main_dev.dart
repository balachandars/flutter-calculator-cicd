import 'package:flutter/material.dart';

import 'app.dart';
import 'app_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const CalculatorApp(
      config: AppConfig(
        environment: AppEnvironment.dev,
        appName: 'Flutter Calculator Dev',
        apiBaseUrl: 'https://dev.example.com',
      ),
    ),
  );
}