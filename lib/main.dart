import 'package:flutter/material.dart';
import 'package:wtf_pos_printer_wifi_bt/screens/HomeScreen.dart';
import 'dart:async';
import 'dart:io';
import 'package:http_server/http_server.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() => runApp(MyApp());

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({@required this.onInit, @required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}
class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if(widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class MyApp extends StatelessWidget {

  Future _startWebServer() async {
    runZoned(() {
      HttpServer.bind(InternetAddress.anyIPv4, 26502).then((server) {

        print('Server running at: ${server.address.address}');

        Fluttertoast.showToast(
            msg: "Server running at: ${server.address.address}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1);

        server.transform(HttpBodyHandler()).listen((HttpRequestBody body) async {
          if (body.request.method == 'POST') {
            switch (body.request.uri.toString()) {
              case "/bill":
                {

                  body.request.response.statusCode = 200;
                  body.request.response.write("hello");
                  body.request.response.close();
                }
                break;
              case "/kot":
                {
                  body.request.response.statusCode = 404;
                  body.request.response.write('Not found');
                  body.request.response.close();
                }
                break;
              default:
                {
                  body.request.response.statusCode = 404;
                  body.request.response.write('Not found');
                  body.request.response.close();
                }
            }
          }
        });
      });
    }, onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        _startWebServer();
      },
      child: MaterialApp(
        title: 'WTF POS Printer',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyHomePage(title: 'WTF POS Printer')
      )
    );
  }
}
