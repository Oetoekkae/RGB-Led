import 'package:flutter/material.dart';
import 'package:rgbled_wifi/UI/wifi_connect_btn.dart';
import 'package:rgbled_wifi/UI/wifi_list.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rgbled_wifi/UI/wifi_title.dart';

class WifiPage extends StatefulWidget {
  @override
  State createState () => new WifiPageState();
}

class WifiPageState extends State<WifiPage> {
  @override
  Widget build(BuildContext context) {
    return new Column(
          children: <Widget>[
            new WifiTitle(),
            new WifiList(true),
            new WifiConnectButton()
          ],
        );
  }
}