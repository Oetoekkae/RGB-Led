import 'package:hex/hex.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:rgbled_wifi/UI/flutter_circle_color_picker.dart';


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
      home: Scaffold(
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