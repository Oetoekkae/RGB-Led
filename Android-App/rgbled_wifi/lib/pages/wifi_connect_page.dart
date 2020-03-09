import 'package:flutter/material.dart';
import 'package:rgbled_wifi/UI/wifi_connect_btn.dart';
import 'package:rgbled_wifi/UI/wifi_list.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rgbled_wifi/UI/wifi_title.dart';
import 'package:rgbled_wifi/pages/main_page.dart';

class WifiPageConnect extends StatefulWidget {
  @override
  State createState () => new WifiPageConnectState();
}

class WifiPageConnectState extends State<WifiPageConnect> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Connect to your LED", style: new TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: new WifiList(),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 150,
        ),
      ),
      floatingActionButton: new Center(
        heightFactor: 0.5,
        child: new FloatingActionButton(
          onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new MainPage())),
          tooltip: "Connect!",
          child: Icon(Icons.wifi_tethering),
        ),
      )
    );
  }
}