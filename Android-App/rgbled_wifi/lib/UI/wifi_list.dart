import 'package:flutter/material.dart';

class WifiList extends StatelessWidget {

  final _ssids = ["wifi1", "wifi2", "wifi3", "wifi4", "wifi5", "wifi6", "wifi7", "wifi8", "wifi9", "wifi10"];
  final _biggerFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return new Material( // True button
      color: Colors.white,
      child: new Center(
        child: new Container(
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.black54,width: 15.0)
          ),
          padding: new EdgeInsets.all(20.0),
          child: new ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: _ssids.length,
            itemBuilder: (context, i) =>
                ListTile(
                  leading: Text("SSID: ", style: _biggerFont,
                  ),
                  title: Text(_ssids[i], style: _biggerFont,
                  ),
                ),
            separatorBuilder: (context, i) => Divider(),
          ),
        ),
      ),
    );
  }
}
