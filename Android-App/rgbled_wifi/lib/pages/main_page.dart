import 'dart:typed_data';
import 'package:hex/hex.dart';
import 'package:flutter/material.dart';
import 'package:rgbled_wifi/UI/wifi_title.dart';
import 'package:rgbled_wifi/UI/color_wheel.dart';
import 'package:rgbled_wifi/UI/color_picker_widget.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';


const String A = "0123456789abcdef";

class MainPage extends StatefulWidget{
  @override
  State createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:Center(
          child: CircleColorPicker(
            initialColor: Colors.blue,
            onChanged: (color) => sendColors(color),
            size: const Size(300, 300),
            strokeWidth: 4,
            thumbSize: 36,
          ),
        ),
        ), //   <--- image
    );
  }
}

void sendColors(Color hexVal) {
  //print(hexVal);
  String tempStr = hexVal.toString();
  List tempList = tempStr.split("Color(0xff");
  String hexValue = tempList[1].toString().substring(0, 6);
  //print(hexValue);

  //ARVOT ON VIELÄ KÄÄNTEISET
  String data = "R=" + HEX.decode(hexValue.substring(0,2)).toString() +
      "&G=" + HEX.decode(hexValue.substring(2,4)).toString() +
      "&B=" + HEX.decode(hexValue.substring(4,6)).toString();
  print(data);
  //print("r, g, b: " + r + ", " + g + ", " + b);
  //print("decoded r, g, b: " + HEX.decode(r).toString() + ", " + HEX.decode(g).toString() + ", " + HEX.decode(b).toString());

}
