import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: calculatorApp(),
  ));
}

class calculatorApp extends StatefulWidget {
  const calculatorApp({super.key});

  @override
  State<calculatorApp> createState() => _calculatorAppState();
}

class _calculatorAppState extends State<calculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var highInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    if (value == "C") {
      input = "";
      output = "";
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        highInput = true;
        outputSize = 52;
      }
    } else {
      highInput = false;
      outputSize = 34;
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //input output area
          Expanded(
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                //color:Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      highInput ? '' : input,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ),

          Row(
            children: [
              Butt(text: "C", buttonBgColor: operator, tColor: orange),
              Butt(text: "<", buttonBgColor: operator, tColor: orange),
              Butt(text: "%", buttonBgColor: operator, tColor: orange),
              Butt(text: "/", buttonBgColor: operator, tColor: orange),
            ],
          ),
          Row(
            children: [
              Butt(text: "7"),
              Butt(text: "8"),
              Butt(text: "9"),
              Butt(text: "x", buttonBgColor: operator, tColor: orange),
            ],
          ),
          Row(
            children: [
              Butt(text: "4"),
              Butt(text: "5"),
              Butt(text: "6"),
              Butt(text: "-", buttonBgColor: operator, tColor: orange),
            ],
          ),
          Row(
            children: [
              Butt(text: "1"),
              Butt(text: "2"),
              Butt(text: "3"),
              Butt(text: "+", buttonBgColor: operator, tColor: orange),
            ],
          ),
          Row(
            children: [
              Butt(text: ""),
              Butt(text: "0"),
              Butt(text: "."),
              Butt(text: "=", buttonBgColor: operator, tColor: orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget Butt({text, tColor = Colors.white, buttonBgColor = button}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(22),
            primary: buttonBgColor,
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
