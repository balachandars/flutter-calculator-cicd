import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

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
    if (_operator.isEmpty) return;
    final double operand2 = double.parse(_display);
    double result = 0;
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

  Widget _buildButton(String label,
      {Color bgColor = const Color(0xFF333333),
      Color textColor = Colors.white,
      int flex = 1}) {
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  _display,
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
