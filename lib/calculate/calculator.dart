import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({
    Key? key,
  }) : super(key: key);

  @override
  State<Calculator> createState() => _Calculator();
}

class _Calculator extends State<Calculator> {
  String history = '';
  String expression = '';
  bool isEqually = false;

  void onButtonPress(buttonText) {
    if (buttonText == '=') {
      execute(buttonText);
    } else if (buttonText == 'C') {
      clear();
    } else if (buttonText == '+/-') {
      var num = int.parse(expression);
      setState(() {
        num *= -1;
        expression = '$num';
      });
    } else {
      clicked(buttonText);
    }
  }

  int isOperator(String button) {
    if (button == '+' ||
        button == '-' ||
        button == '*' ||
        button == '/' ||
        button == '=') {
      return 1;
    } else if (button == 'C' || button == '+/-' || button == '%') {
      return 2;
    } else {
      return 3;
    }
  }

  List<String> buttons = [
    'C',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '00',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF17171C),
                      border: Border.all(
                          color: const Color(0xFF17171C), width: 4.0),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          history,
                          style: const TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 40,
                              color: Color.fromRGBO(255, 255, 255, 0.4)),
                        ),
                      ),
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF17171C),
                      border: Border.all(
                          color: const Color(0xFF17171C), width: 4.0),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          expression,
                          style: const TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.w300,
                              fontSize: 60,
                              color: Color(0xFFFFFFFF)),
                        ),
                      ),
                    )),
              ),
            ],
          )),
      Expanded(
        flex: 6,
        child: Container(
          color: const Color(0xFF17171C),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              padding: const EdgeInsets.all(0.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemCount: buttons.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: MaterialButton(
                    minWidth: 10,
                    height: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    color: isOperator(buttons[index]) == 1
                        ? const Color(0xFF4B5EFC)
                        : isOperator(buttons[index]) == 2
                            ? const Color(0xFF4E505F)
                            : const Color(0xFF2E2F38),
                    textColor: Colors.white,
                    onPressed: () {
                      onButtonPress(buttons[index]);
                    },
                    child: Text(buttons[index],
                        style: const TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4))),
              ),
            ),
          ),
        ),
      ),
    ]));
  }

  void execute(String button) {
    Parser parser = Parser();
    Expression exp = parser.parse(expression);
    ContextModel contextModel = ContextModel();

    setState(() {
      history = expression;
      isEqually = true;
      expression = exp.evaluate(EvaluationType.REAL, contextModel).toString();
    });
  }

  bool clicked(String button) {
    if (button == '0' && expression == '' ||
        button == '00' && expression == '' ||
        button == '.' && expression == '') {
      setState(() {
        expression += '0.';
      });
    } else if (isEqually == true) {
      setState(() {
        expression = button;
        isEqually = false;
      });
    } else {
      setState(() {
        expression += button;
      });
    }
    return true;
  }

  void clear() {
    setState(() {
      history = '';
      expression = '';
    });
  }
}
