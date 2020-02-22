import 'package:flutter/material.dart';
import 'package:rgbled_wifi/UI/wifi_list.dart';

class WifiPage extends StatefulWidget {
  @override
  State createState () => new WifiPageState();
}

class WifiPageState extends State<WifiPage> {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new WifiList(true),
            new WifiList(false)
          ],
        )
      ],
    );
  }
}