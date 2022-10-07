import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "0";
  String expression = "";

  buttonPressed(String value) {
    setState(() {
      if (value == "AC") {
        result = "0";
      } else if (value == ".") {
        if (result.contains(".")) {
          return;
        } else {
          result = result + value;
        }
      } else if (value == "=") {
        expression = result.replaceAll("x", "*");

        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();

        dynamic calculate = exp.evaluate(EvaluationType.REAL, cm);

        result = "$calculate";
      } else {
        if (result == "0") {
          result = value;
        } else {
          result = result + value;
        }
      }
    });
  }

  Widget _button(String buttonLabel) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonLabel),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            buttonLabel,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            // Expanded(child: Divider()),
            Column(
              children: [
                Row(
                  children: [
                    _button("7"),
                    _button("8"),
                    _button("9"),
                    _button("/"),
                  ],
                ),
                Row(
                  children: [
                    _button("4"),
                    _button("5"),
                    _button("6"),
                    _button("x"),
                  ],
                ),
                Row(
                  children: [
                    _button("1"),
                    _button("2"),
                    _button("3"),
                    _button("-"),
                  ],
                ),
                Row(
                  children: [
                    _button("."),
                    _button("0"),
                    _button("00"),
                    _button("+"),
                  ],
                ),
                Row(
                  children: [
                    _button("AC"),
                    _button("="),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
