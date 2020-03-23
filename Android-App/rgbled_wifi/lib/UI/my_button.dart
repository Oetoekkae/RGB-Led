import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{

  final String _name;
  MyButton(this._name);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
        child: new InkWell(
              onTap: () => print("tap, tap, tapity, tap on " + _name),
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