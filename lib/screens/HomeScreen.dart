import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_server/http_server.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'BluetoothScreen.dart';
import 'WiFiScreen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WTF POS Printer'),
          actions: <Widget>[new Icon(Icons.more_vert)],
        ),
        body: Center(
            child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text("AVAILABLE MODES")),
              ListTile(
                  leading: Icon(Icons.network_wifi, size: 28),
                  title: Text('Wi-Fi'),
                  subtitle: Text('TMLIK Connected'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    print('Wifi');
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new WifiScreen(title: 'Wifi Config.')),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.bluetooth, size: 28),
                  title: Text('Bluetooth'),
                  subtitle: Text('Printer001 Connected'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    print('Bluetooth');
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new BluetoothScreen(title: 'Bluetooth Config.')),
                    );
                  }),
              Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text("CONSOLE")),
              Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    enabled: false,
                    style: TextStyle(
                        fontFamily: Platform.isIOS ? "Courier" : "monospace",
                        fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            "sdifu sadfiusaidufoisdaufoisdau fisadfiosdufnoiasudnfoisaudfoisuadfoiusdofiuosdifnuoisdunfoisadnfoisunadfouasdoifusdiuafnoiasudfodsnaou"),
                    maxLines: 40,
                  ))
            ])));
  }
}
