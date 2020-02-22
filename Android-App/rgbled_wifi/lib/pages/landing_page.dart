import 'package:flutter/material.dart';
import './wifi_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new WifiPage())),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("COOL RGB LED", style: new TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),),
            new Text("Tap anywhere to continue" ,style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}