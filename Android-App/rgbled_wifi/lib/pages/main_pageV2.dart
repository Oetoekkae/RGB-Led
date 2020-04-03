import 'package:hex/hex.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:rgbled_wifi/UI/flutter_circle_color_picker.dart';
import 'package:rgbled_wifi/UI/my_button.dart';
import 'package:rgbled_wifi/UI/secondary_light_switch.dart';


const String A = "0123456789abcdef";
final String host = "192.168.4.1";
final _biggerFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);
bool _isSending = false;
bool _secondaryLed = false;
Color _bgColor = Colors.blue;


class MainPageV2 extends StatefulWidget{

  @override
  State createState() => new MainPageV2State();
}

class MainPageV2State extends State<MainPageV2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: _bgColor,
          body: new Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  //alignment: Alignment.center,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Primary Color", style: new TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black54,
                ),

                child: Center(
                  child: CircleColorPicker(
                    initialColor: Colors.blue,
                    onChanged: (color) {
                      setState(() {
                        _request(color);
                      });
                    },
                    size: const Size(300, 300),
                    strokeWidth: 4,
                    thumbSize: 36,
                  ),
                ),
              ),
              Container(
                  color: Colors.black,
                  child: Row(
                    children: <Widget>[
                      SecondaryLightSwitch(),
                    ],
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black54
                ),
                child: Center(
                  child: CircleColorPicker(
                    initialColor: Colors.blue,
                    onChanged: (color) {
                      setState(() {
                        _request(color);
                      });
                    },
                    size: const Size(300, 300),
                    strokeWidth: 4,
                    thumbSize: 36,
                  ),
                ),
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

_requestRainbows() {
  _isSending = true;
  var uri = Uri.http(host, '/RAINBOW!');
  Map<String, String> headers = {"Content-type": "text/html"};
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
    _bgColor = hexVal;
    //setBgColor(hexVal);
    return;
  }
  print("Can't, still sending this previous");
}
void setBgColor(Color bg) {
  _bgColor = bg;
  //print(bg.toString());
}

List<Widget> spawnButtons(int ammount) {
  List<Widget> buttons = [];
  buttons.add(MyButton("Rainbows!", true, () => _requestRainbows()));
  for(int i = 0; i<ammount;i++) {
    buttons.add(MyButton("Button " + (i+1).toString(), false, () => print("not this")));
  }
  return buttons;
}