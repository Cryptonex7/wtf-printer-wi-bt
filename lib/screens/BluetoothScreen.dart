import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:flutter/material.dart';

class BluetoothScreen extends StatefulWidget {
  BluetoothScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothScreen> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  int _selectedIndex = null;

  /// int counter = 0;

  @override
  void initState() {
    super.initState();

    /// Type varble = Consumer<Type>
    printerManager.scanResults.listen((devices) async {
      setState(() {
        _devices = devices;
        // counter =1;
      });
    });
  }

  void _startScanDevices() {
    setState(() {
      _devices = [];
    });
    printerManager.startScan(Duration(seconds: 5));
  }

  void _stopScanDevices() {
    printerManager.stopScan();
  }

  void handleChangeList(val) {
    setState(() {
      _selectedIndex = val;
    });
  }

  Future<void> _neverSatisfied(Map printer) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SET PRINTER',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to select the below printer ?',
                    style: TextStyle(fontSize: 14)),
                ListTile(
                  title: Text(printer['name']),
                  subtitle: Text(printer['address']),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('SET PRINTER'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// if (_devices.length ==0 ) call();
    /// if (counter == 0) {...}
    /// final _deviceState = Provider.of<BluetoothPrinterModle>(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), elevation: 0.0),
      body: _devices.isEmpty
          ? Column(
              children: <Widget>[
                Padding(
                    child: Text("SELECTED PRINTER"),
                    padding: EdgeInsets.only(left: 16, top: 16)),
                ListTile(
                  leading: Icon(Icons.print, size: 28),
                  title: Text("Helooooo Worllllsss"),
                  subtitle: Text("Hello"),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.bluetooth_searching,
                        color: Colors.grey,
                        size: 84.0,
                      ),
                      Text("No Bluetooth Devices",
                          style: TextStyle(fontSize: 18)),
                      Text("Scan for devices by clicking the button below")
                    ])
              ],
            )
          : Column(children: <Widget>[
              Padding(
                  child: Text("SELECTED PRINTER", textAlign: TextAlign.center),
                  padding: EdgeInsets.only(left: 16, top: 16)),
              ListTile(
                leading: Icon(Icons.print, size: 28),
                title: Text("Helooooo Worllllsss"),
                subtitle: Text("Hello"),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _devices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Icon(Icons.print, size: 28),
                            title: Text(_devices[index].name ?? ''),
                            subtitle: Text(_devices[index].address),
                            trailing: Radio(
                                value: index,
                                groupValue: _selectedIndex,
                                onChanged: (val) => handleChangeList(val)),
                            onTap: () {
                              _neverSatisfied({
                                'name': _devices[index].name,
                                'address': _devices[index].address
                              });
                              handleChangeList(index);
                            });
                      }))
            ]),
      floatingActionButton: StreamBuilder<bool>(
        stream: printerManager.isScanningStream,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: _stopScanDevices,
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: _startScanDevices,
            );
          }
        },
      ),
    );
  }
}
