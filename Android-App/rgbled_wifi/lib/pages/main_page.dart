import 'package:hex/hex.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';


const String A = "0123456789abcdef";
final _biggerFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);

class MainPage extends StatefulWidget{
  @override
  State createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Center(
              child: CircleColorPicker(
                initialColor: Colors.blue,
                onChanged: (color) => _makePostReq(color),
                size: const Size(300, 300),
                strokeWidth: 4,
                thumbSize: 36,
              ),
              heightFactor: 1.3,
            ),
            Expanded(
              child: Container(
                child: new ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: 5,
                  itemBuilder: (context, i) =>
                      ListTile(
                        leading: Text("SSID: ", style: _biggerFont,
                        ),
                        title: Text(i.toString(), style: _biggerFont,
                        ),
                      ),
                  separatorBuilder: (context, i) => Divider(),

                ),
              ),
            ),
          ],
        ),
        ), //   <--- image
    );
  }
}

_makePostReq(Color hexVal) {
  String tempStr = hexVal.toString();
  List tempList = tempStr.split("Color(0xff");
  String hexValue = tempList[1].toString().substring(0, 6);
  var uri = Uri.http('192.168.4.1', '/colors', {'R' : HEX.decode(hexValue.substring(0,2)).toString(),
                                                'G' : HEX.decode(hexValue.substring(2,4)).toString(),
                                                'B' : HEX.decode(hexValue.substring(4,6)).toString()});
  Map<String, String> headers = {"Content-type":"text/html"};
  Future<void> response = post(uri, headers:headers)
      .then((response) => print(response.body))
      .catchError((error) => print(error));
}
