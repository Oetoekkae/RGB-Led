import 'package:flutter/material.dart';

class WifiConnectButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
          child: new InkWell(
            onTap: () => print("Sie painoit"),
              child: new Container(
                child: Text("Connect",
                  style: new TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                color: Colors.blueAccent,
                padding: EdgeInsets.all(35),
                margin: EdgeInsets.all(15),
                alignment: Alignment.center,
              ),
            ),
          //color: Colors.blueAccent,
          //margin: EdgeInsets.all(30),
        ),
    );
  }
}