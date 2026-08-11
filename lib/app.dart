import 'package:flutter/material.dart';

import 'app_config.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({required this.config, super.key});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: CalculatorScreen(config: config),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({required this.config, super.key});

  final AppConfig config;

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double _operand1 = 0;
  String _operator = '';
  bool _shouldResetDisplay = false;

  void _onDigit(String digit) {
    setState(() {
      if (_shouldResetDisplay || _display == '0') {
        _display = digit;
        _shouldResetDisplay = false;
      } else {
        _display += digit;
      }
    });
  }

  void _onDecimal() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _onOperator(String op) {
    setState(() {
      _operand1 = double.parse(_display);
      _operator = op;
      _shouldResetDisplay = true;
    });
  }

  void _onEquals() {
    if (_operator.isEmpty) {
      return;
    }

    final operand2 = double.parse(_display);
    var result = 0.0;

    switch (_operator) {
      case '+':
        result = _operand1 + operand2;
      case '-':
        result = _operand1 - operand2;
      case '×':
        result = _operand1 * operand2;
      case '÷':
        result = operand2 != 0 ? _operand1 / operand2 : 0;
    }

    setState(() {
      _display = _formatResult(result);
      _operator = '';
      _shouldResetDisplay = true;
    });
  }

  void _onClear() {
    setState(() {
      _display = '0';
      _operand1 = 0;
      _operator = '';
      _shouldResetDisplay = false;
    });
  }

  void _onToggleSign() {
    setState(() {
      final value = double.parse(_display) * -1;
      _display = _formatResult(value);
    });
  }

  void _onPercent() {
    setState(() {
      final value = double.parse(_display) / 100;
      _display = _formatResult(value);
    });
  }

  String _formatResult(double value) {
    return value == value.truncateToDouble()
        ? value.toInt().toString()
        : value.toString();
  }

  Widget _buildButton(
    String label, {
    Color bgColor = const Color(0xFF333333),
    Color textColor = Colors.white,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: textColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () {
            if (label == 'C') {
              _onClear();
            } else if (label == '+/-') {
              _onToggleSign();
            } else if (label == '%') {
              _onPercent();
            } else if (label == '=') {
              _onEquals();
            } else if (label == '.') {
              _onDecimal();
            } else if (['+', '-', '×', '÷'].contains(label)) {
              _onOperator(label);
            } else {
              _onDigit(label);
            }
          },
          child: Text(label, style: TextStyle(fontSize: 26, color: textColor)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFFF9F0A);
    const darkGray = Color(0xFF1C1C1E);
    const lightGray = Color(0xFFA5A5A5);
    const buttonGray = Color(0xFF333333);

    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        title: Text(widget.config.appName),
        backgroundColor: darkGray,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.config.isProduction
                      ? 'Production environment'
                      : 'Development environment',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  _display,
                  key: const Key('calculator_display'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            _buildRow([
              _buildButton('C', bgColor: lightGray, textColor: Colors.black),
              _buildButton('+/-', bgColor: lightGray, textColor: Colors.black),
              _buildButton('%', bgColor: lightGray, textColor: Colors.black),
              _buildButton('÷', bgColor: orange),
            ]),
            _buildRow([
              _buildButton('7', bgColor: buttonGray),
              _buildButton('8', bgColor: buttonGray),
              _buildButton('9', bgColor: buttonGray),
              _buildButton('×', bgColor: orange),
            ]),
            _buildRow([
              _buildButton('4', bgColor: buttonGray),
              _buildButton('5', bgColor: buttonGray),
              _buildButton('6', bgColor: buttonGray),
              _buildButton('-', bgColor: orange),
            ]),
            _buildRow([
              _buildButton('1', bgColor: buttonGray),
              _buildButton('2', bgColor: buttonGray),
              _buildButton('3', bgColor: buttonGray),
              _buildButton('+', bgColor: orange),
            ]),
            _buildRow([
              _buildButton('0', bgColor: buttonGray, flex: 2),
              _buildButton('.', bgColor: buttonGray),
              _buildButton('=', bgColor: orange),
            ]),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(List<Widget> buttons) => Row(children: buttons);
}