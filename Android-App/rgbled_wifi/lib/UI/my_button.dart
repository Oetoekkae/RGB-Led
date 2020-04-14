import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MyButton extends StatelessWidget{

  final String _name;
  String color;
  final VoidCallback _onTap;
  final List<Color> _colors = [
    Colors.pink,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.teal
  ];

  MyButton( this._name, this._onTap, [this.color]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: getColor(this.color),


        ),
        shape: BoxShape.rectangle,
        color: Colors.greenAccent,
        border: Border.all(
            width: 2,
            color: Colors.black
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
        child: new InkWell(
              onTap: () => _onTap(),
              child: new Container(
                child: Text(_name,
                  style: new TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                alignment: Alignment.center,
              ),
        ),
    );
  }


}

List<Color> getColor(String widgetId) {
  switch (widgetId) {
    case "rainbow":
      return [
        Colors.pink,
        Colors.red,
        Colors.green,
        Colors.purple,
        Colors.teal
      ];
    case "rgb":
      return [
        Colors.blue,
        Colors.red,
        Colors.green

      ];
    default:
      return [
        Colors.white,
        Colors.white
      ];
  }
}