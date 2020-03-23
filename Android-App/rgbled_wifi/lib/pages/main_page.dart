import 'package:hex/hex.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:rgbled_wifi/UI/flutter_circle_color_picker.dart';
import 'package:rgbled_wifi/UI/my_button.dart';


const String A = "0123456789abcdef";
final String host = "192.168.4.1";
final _biggerFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);
bool _isSending = false;
Color _bgColor = Colors.blue;
class MainPage extends StatefulWidget{
  @override
  State createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: _bgColor,
          body: new Column(
              children: <Widget>[
                  CircleColorPicker(
                    initialColor: Colors.blue,
                    onChanged: (color) => _request(color),
                    size: const Size(300, 300),
                    strokeWidth: 4,
                    thumbSize: 36,
                  ),
                Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: MyButton("Button 1"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: MyButton("Button 2"),
                      ),
                      Container(
                          padding: const EdgeInsets.all(2),
                          child: MyButton("Button 3"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: MyButton("Button 4"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: MyButton("Button 5"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: MyButton("Button 6"),
                      ),
                    ],
                  )
                ),
              ],
            ),
        ),
      ),//   <--- image
    );
  }
}

_makePostReq(Color hexVal) {
  _isSending = true;
  String tempStr = hexVal.toString();
  List tempList = tempStr.split("Color(0xff");
  String hexValue = tempList[1].toString().substring(0, 6);
  var uri = Uri.http(host, '/colors', {'R' : HEX.decode(hexValue.substring(0,2)).toString(),
                                                'G' : HEX.decode(hexValue.substring(2,4)).toString(),
                                                'B' : HEX.decode(hexValue.substring(4,6)).toString()});
  Map<String, String> headers = {"Content-type":"text/html"};
  Future<void> response = put(uri, headers:headers)
      .then((response) => getResponse(response))
      .catchError((error) => print(error));
}

void getResponse(Response response) {
  _isSending = false;
  print("Done, " + response.body);
}

void _request(Color hexVal) {
  if(!_isSending) {
    print(hexVal);
    _makePostReq(hexVal);
    setBgColor(hexVal);
    return;
  }
  print("Can't, still sending this previous");
}
void setBgColor(Color bg) {
  _bgColor = bg;
  //print(bg.toString());
}