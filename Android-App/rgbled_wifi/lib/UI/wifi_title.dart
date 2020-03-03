import 'package:flutter/material.dart';

class WifiTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Center(
          child: new Container(
            child: new Column(
              children: <Widget> [
                Text("Connect to your",
                  style: new TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                ),
                Text("LED",
                  style: new TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            color: Colors.blueAccent,
          ),
        ),
      );

  }

}