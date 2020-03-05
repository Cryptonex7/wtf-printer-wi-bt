import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';


class BluetoothPrinterModel extends ChangeNotifier {
  List<PrinterBluetooth> _list = [];
  PrinterBluetooth selectedPrinter;

  List<PrinterBluetooth> get allPrinters => this._list;
  PrinterBluetooth get getSelectedPrinter => this.selectedPrinter;

  void setPrinterList(List<PrinterBluetooth> printers) {
    this._list = printers;
    notifyListeners();
  }

  void setPrinter(PrinterBluetooth printer) {
    this.selectedPrinter = printer;
    notifyListeners();
  }
}