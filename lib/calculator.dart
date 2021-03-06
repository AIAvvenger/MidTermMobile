import 'package:flutter/material.dart';
import 'package:flutter_app/display.dart';
import 'package:flutter_app/key-controller.dart';
import 'package:flutter_app/key-pad.dart';
import 'package:flutter_app/processor.dart';

class Calculator extends StatefulWidget {

  Calculator({ Key key }) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String _output;

  @override
  void initState() {

    KeyController.listen((event) => Processor.process(event));
    Processor.listen((data) => setState(() { _output = data; }));
    Processor.refresh();
    super.initState();
  }

  @override
  void dispose() {

    KeyController.dispose();
    Processor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size screen = MediaQuery.of(context).size;

    double buttonSize = screen.width / 4;
    double displayHeight = screen.height - (buttonSize * 5) - (buttonSize);

    return Scaffold(
      backgroundColor: Color.fromARGB(196, 0, 0, 0),
      body: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Display(value: _output, height: displayHeight),
            KeyPad()
          ]
      ),
    );
  }
}