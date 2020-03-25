import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{

  final String _name;
  final bool rainbow;
  final VoidCallback _onTap;
  final List<Color> _colors = [
    Colors.pink,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.teal
  ];

  MyButton( this._name, this.rainbow, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: rainbow == true ? _colors:[Colors.teal, Colors.teal],
          //stops: _colors.length * 1.0,


        ),
        shape: BoxShape.rectangle,
        color: Colors.greenAccent,
        border: Border.all(
            width: 2,
            color: Colors.black
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
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