import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../services/isar.dart';

class AddKeyProvider with ChangeNotifier {
  PixKeyTypes? _keyType;
  String? _bankName;
  MaskTextInputFormatter? inputMask;
  TextInputType? keyboardType;
  PixKey? editPixKey;
  late String label;

  AddKeyProvider({this.editPixKey}) {
    if (editPixKey != null) {
      selectKeyType(editPixKey!.type);
      _bankName = editPixKey!.bankName;
    }
  }

  PixKeyTypes? get selectedKey => _keyType;
  String? get bankName => _bankName;

  selectKeyType(PixKeyTypes type) {
    switch (type) {
      case PixKeyTypes.phone:
        label = 'celular';
        keyboardType = TextInputType.number;
        inputMask = MaskTextInputFormatter(
            mask: '(##) #####-####', filter: {'#': RegExp(r'[0-9]')});
        break;
      case PixKeyTypes.email:
        label = 'email';
        break;
      case PixKeyTypes.cpf:
        label = 'CPF';
        keyboardType = TextInputType.number;
        inputMask = MaskTextInputFormatter(
            mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
        break;
      case PixKeyTypes.cnpj:
        label = 'CNPJ';
        keyboardType = TextInputType.number;
        inputMask = MaskTextInputFormatter(
            mask: '##.###.###/####-##', filter: {'#': RegExp(r'[0-9]')});
        break;
      case PixKeyTypes.randomKey:
        label = 'chave aleatória';
        inputMask = MaskTextInputFormatter(
            mask: '########-####-####-####-########',
            filter: {'#': RegExp(r'[0-9a-zA-z]')});
        break;
    }
    _keyType = type;
    notifyListeners();
  }

  selectBank(String bank) {
    _bankName = bank;
    notifyListeners();
  }

  saveKey(String value, String description) async {
    if (_keyType == null || _bankName == null) {
      throw ErrorDescription(
          'Key addition failed. One or more values are missing.');
    }

    if (editPixKey != null) {
      final addedPixKey = await IsarDatabase.isar.writeTxn(() => IsarDatabase
          .isar.pixKeys
          .filter()
          .valueEqualTo(editPixKey!.value)
          .findFirst());

      if (addedPixKey != null) {
        debugPrint('ok');
        addedPixKey.bankName = _bankName!;
        addedPixKey.description = description;
        addedPixKey.value = value;

        await IsarDatabase.isar
            .writeTxn(() => IsarDatabase.isar.pixKeys.put(addedPixKey));
      }
      return;
    }

    await IsarDatabase.isar.writeTxn(() => IsarDatabase.isar.pixKeys.put(PixKey(
        type: _keyType!,
        bankName: _bankName!,
        value: value,
        description: description)));
  }
}
