import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rgbled_wifi/pages/wifi_page.dart';
import 'package:rgbled_wifi/pages/wifi_connect_page.dart';
import 'package:rgbled_wifi/pages/main_pageV2.dart';
import './pages/landing_page.dart';
import 'package:connectivity/connectivity.dart';

void main(){
runApp(new MaterialApp(
    home: new MainPageV2(),
  ));


}