import 'package:flutter/material.dart';
import 'package:rgbled_wifi/UI/customicons/bulb_icons_icons.dart';

final widgetText =  const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white);

class SecondaryLightSwitch extends StatefulWidget{
  SecondaryLightSwitch({Key key,
  this.onChanged});

  final ValueChanged<bool> onChanged;

  @override
  _SecondaryLightSwicthState createState() => _SecondaryLightSwicthState();

}

class _SecondaryLightSwicthState extends State<SecondaryLightSwitch> {
  bool _secondaryLed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SwitchListTile(
        title: Text("Secondary color", style: widgetText),
        value: _secondaryLed,
        onChanged: (bool value) {
          setState(() {
            _secondaryLed = value;
          });
      },
      secondary: Icon(_secondaryLed == true ? Icons.lightbulb_outline : Icons.highlight),
      ),
    );
  }
}