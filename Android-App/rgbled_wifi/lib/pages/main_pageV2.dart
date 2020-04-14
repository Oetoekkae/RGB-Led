import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hex/hex.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/painting.dart';
import 'package:rgbled_wifi/UI/flutter_circle_color_picker.dart';
import 'package:rgbled_wifi/UI/my_button.dart';
import 'package:rgbled_wifi/UI/secondary_light_switch.dart';
import 'package:rgbled_wifi/UI/customicons/bulb_icons_icons.dart';
import 'package:flutter/foundation.dart';



const String A = "0123456789abcdef";
final String host = "192.168.4.1";
final _biggerFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);
bool _isSending = false;
bool _secondaryLed = true;
Color _bgColor = Colors.blue;
Color _bgColorSec = Colors.blue;



class MainPageV2 extends StatefulWidget{

  @override
  State createState() => new MainPageV2State();
}

class MainPageV2State extends State<MainPageV2> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            child: Container(
              height: 15,
            ),
          ),
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black45,
            ),
            child: Drawer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0, 0.3, 0.5, 0.6, 0.7, 1],
                    colors: [Colors.black, Colors.black87, Colors.black54,
                    Colors.black45, Colors.black38, Colors.black12]
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        //color: Colors.black45
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                            stops: _secondaryLed == true ? [0, 0.7] : [0],
                            colors: _secondaryLed == true ? [_bgColor, _bgColorSec] : [_bgColor]
                          )
                        ),
                        child: Center(
                          child: Text(
                            "Color effects",
                            style: _biggerFont,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1
                              )
                          )
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: 10,
                              child: Text(
                                "Flash the leds with the might of an rainbow!",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                          MyButton("Rainbows!",
                                  () => _makeRequest(host, '/Rainbow'),  "rainbow"),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1
                              )
                          )
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: 10,
                              child: Text(
                                "Loop trough Red, Green and Blue",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                          MyButton("RBG Loop", () => _makeRequest(host, '/LOOPRGB!'), "rgb"),
                        ]
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1
                              )
                          )
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: 10,
                              child: Text(
                                "Get completely random color!",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                          MyButton("Random!", () => _makeRequest(host, '/random')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //backgroundColor: _bgColor,
          body: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: _bgColor,
                  ),

                  child: Center(
                    child: CircleColorPicker(
                      initialColor: Colors.blue,
                      onChanged: (color) {
                        setState(() {
                          _request(color, 0);
                        });
                      },
                      //size: const Size(290, 290),
                      strokeWidth: 4,
                      thumbSize: 36,
                    ),
                  ),
                ),
              ),
              Container(
                  color: Colors.black87,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SwitchListTile(
                          title: Text("Secondary color", style: widgetText),
                          value: _secondaryLed,
                          onChanged: (bool value) {
                            setState(() {
                              _secondaryLed = value;
                              activateSecondary(value);
                            });
                          },
                          secondary: Icon(_secondaryLed == true ? BulbIcons.lightbulb : BulbIcons.lightbulb_1, color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),
              _secondaryLed == true ? Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: _bgColorSec,
                  ),
                child: Center(
                  child: CircleColorPicker(
                    initialColor: Colors.blue,
                    onChanged: (color) {
                      setState(() {
                        _request(color, 1);
                      });
                    },
                    size: const Size(300, 300),
                    strokeWidth: 4,
                    thumbSize: 36,
                  ),
                ),
              ),
              ): Expanded(
                child: Stack(
                    children: <Widget>[
                      Center(
                        child: CircleColorPicker(
                          initialColor: Colors.blue,
                          onChanged: (color) {
                            setState(() {
                              _request(color, 1);
                            });
                          },
                          //size: const Size(300, 300),
                          strokeWidth: 4,
                          thumbSize: 36,
                        ),
                      ),
                      Container(
                        color: Colors.black87  ,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(25),
                            child: Text("Turn on the second led to control it",
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
      ),//   <--- image
    );
  }
}

_makePostReq(Color hexVal, int led) {
  _isSending = true;
  String ledNum;
  if(led == 1 && _secondaryLed){
    ledNum = "1";
  } else {
    ledNum = "0";
  }
  String tempStr = hexVal.toString();
  List tempList = tempStr.split("Color(0xff");
  String hexValue = tempList[1].toString().substring(0, 6);
  var uri = Uri.http(host, '/colors', {'LED' : ledNum, 'Secondary' : _secondaryLed ? '1':'0', 'R' : HEX.decode(hexValue.substring(0,2)).toString(),
    'G' : HEX.decode(hexValue.substring(2,4)).toString(),
    'B' : HEX.decode(hexValue.substring(4,6)).toString()});
  Map<String, String> headers = {"Content-type":"text/html"};
  Future<void> response = put(uri, headers:headers)
      .then((response) => getResponse(response))
      .catchError((error) => print(error));
}
void _request(Color hexVal, int led) {
  if(!_isSending) {
    print(hexVal);
    _makePostReq(hexVal, led);
    if(led == 1) {
      print("led is 1, change secondary bg");
      _bgColorSec = hexVal;
    } else {
      _bgColor = hexVal;
    }
    //setBgColor(hexVal);
    return;
  }
  print("Can't, still sending this previous");
}

_makeRequest(String host, String URL) {
  _isSending = true;
  var uri = Uri.http(host, URL);
  Map<String, String> headers = {"Content-type": "text/html"};
  Future<void> response = put(uri, headers:headers)
      .then((response) => getResponse(response))
      .catchError((error) => print(error));
}

void getResponse(Response response) {
  _isSending = false;
  print("Done, " + response.body);
}

/*List<Widget> spawnButtons(int ammount) {
  List<Widget> buttons = [];
  buttons.add(MyButton("Rainbows!", "rainbows", () => _makeRequest(host, '/RAINBOW!')));
  for(int i = 0; i<ammount;i++) {
    buttons.add(MyButton("Button " + (i+1).toString(), "" () => print("not this")));
  }
  return buttons;
}*/

void activateSecondary(bool onOff) {
  print("Jotain tpahtui");
  if(onOff){
    _secondaryLed = true;
  } else {
    _secondaryLed = false;
  }
  print("_secondaryLed = " + _secondaryLed.toString());
}