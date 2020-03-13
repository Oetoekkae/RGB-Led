import 'dart:typed_data';
import 'package:hex/hex.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rgbled_wifi/UI/wifi_title.dart';
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
            onChanged: (color) => _makePostReq(color),
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
  String data = " R=" + HEX.decode(hexValue.substring(0,2)).toString() +
      "&G=" + HEX.decode(hexValue.substring(2,4)).toString() +
      "&B=" + HEX.decode(hexValue.substring(4,6)).toString();
  print(data);
  //print("r, g, b: " + r + ", " + g + ", " + b);
  //print("decoded r, g, b: " + HEX.decode(r).toString() + ", " + HEX.decode(g).toString() + ", " + HEX.decode(b).toString());

}


_makePostReq(Color hexVal) {
  //color related
  String tempStr = hexVal.toString();
  List tempList = tempStr.split("Color(0xff");
  String hexValue = tempList[1].toString().substring(0, 6);
  /*String data = "?R=" + HEX.decode(hexValue.substring(0,2)).toString() +
      "&G=" + HEX.decode(hexValue.substring(2,4)).toString() +
      "&B=" + HEX.decode(hexValue.substring(4,6)).toString();
  */
  //post request
  var uri = Uri.http('192.168.4.1', '/colors', {'R' : HEX.decode(hexValue.substring(0,2)).toString(),
                                                  'G' : HEX.decode(hexValue.substring(2,4)).toString(),
                                                    'B' : HEX.decode(hexValue.substring(4,6)).toString()});
  Map<String, String> headers = {"Content-type":"text/html"};
  //String body = data;
  //print("data: " + data);
  Future<void> response = post(uri, headers:headers)
      .then((response) => print(response.body))
      .catchError((error) => print(error));
  /*Response response = await post(uri, headers: headers, body: body);
  print(response);
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('A network error occurred');
  }*/

}
