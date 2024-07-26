import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:app_cobranca_pix/utils/index.dart';
import 'package:flutter/material.dart';

class CreateBillingProvider with ChangeNotifier {
  PixKey? selectedKey;
  double? _value;
  String? qrCode;

  CreateBillingProvider({this.selectedKey});

  void selectKey(PixKey key) {
    selectedKey = key;
    notifyListeners();
  }

  void changeValue(double value) {
    _value = value;
    notifyListeners();
  }

  createBilling() {
    if (selectedKey == null) throw ErrorDescription('Cannot create a billing without a PIX key.');
    final String brCode = getBrCode(selectedKey!, _value);

    qrCode = brCode;
    notifyListeners();
  }
}
