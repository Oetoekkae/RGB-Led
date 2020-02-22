import 'package:flutter/material.dart';

class WifiList extends StatelessWidget {

  final _suggestions = ["wifi1", "wifi2", "wifi3", "wifi4", "wifi5", "wifi6", "wifi7"];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final bool _answer;
  WifiList(this._answer);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Material( // True button
        color: _answer == true ? Colors.greenAccent : Colors.redAccent,
          child: new Center(
            child: new Container(
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.white,width: 5.0)
              ),
              padding: new EdgeInsets.all(20.0),
              child: new ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, i) {
                    if (i.isOdd) return Divider();
                    final index = i ~/2;
                    return  ListTile(
                      leading: Text(
                        "SSID: ",
                        style: _biggerFont,
                      ),
                      title: Text(
                        _suggestions[index],
                        style: _biggerFont,
                      ),
                    );
                  }),
            ),
          ),
      ),
    );
  }
}

