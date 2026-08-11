import 'package:flutter/material.dart';

import 'app.dart';
import 'app_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CalculatorApp(config: AppConfig.fromEnvironment()));
}
