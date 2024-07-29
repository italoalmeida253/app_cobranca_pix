import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/models/bank.dart';
import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../services/isar.dart';

class AddKeyProvider with ChangeNotifier {
  PixKeyTypes? _keyType;
  Bank? _bank;
  MaskTextInputFormatter? inputMask;
  TextInputType? keyboardType;
  PixKey? editPixKey;
  PixKeyTypes? get selectedKey => _keyType;
  Bank? get bank => _bank;
  late String label;

  AddKeyProvider({this.editPixKey}) {
    if (editPixKey != null) {
      selectKeyType(editPixKey!.type);
      _bank =
          Bank(name: editPixKey!.bankName, logoAssetName: editPixKey!.bankLogo);
    }
  }

  selectKeyType(PixKeyTypes type) {
    switch (type) {
      case PixKeyTypes.phone:
        label = 'Insira seu celular';
        keyboardType = TextInputType.number;
        inputMask = MaskTextInputFormatter(
            mask: '(##) #####-####', filter: {'#': RegExp(r'[0-9]')});
        break;
      case PixKeyTypes.email:
        label = 'Insira seu email';
        break;
      case PixKeyTypes.cpf:
        label = 'Insira seu CPF';
        keyboardType = TextInputType.number;
        inputMask = MaskTextInputFormatter(
            mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
        break;
      case PixKeyTypes.cnpj:
        label = 'Insira seu CNPJ';
        keyboardType = TextInputType.number;
        inputMask = MaskTextInputFormatter(
            mask: '##.###.###/####-##', filter: {'#': RegExp(r'[0-9]')});
        break;
      case PixKeyTypes.randomKey:
        label = 'Insira sua chave aleatória';
        inputMask = MaskTextInputFormatter(
            mask: '########-####-####-####-############',
            filter: {'#': RegExp(r'[0-9a-zA-z]')});
        break;
    }
    _keyType = type;
    notifyListeners();
  }

  selectBank(Bank bank) {
    _bank = bank;
    notifyListeners();
  }

  saveKey(String value, String description) async {
    if (_keyType == null || _bank == null) {
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
        addedPixKey.bankName = _bank!.name;
        addedPixKey.bankLogo = _bank!.logoAssetName;
        addedPixKey.description = description;
        addedPixKey.value = value;

        await IsarDatabase.isar
            .writeTxn(() => IsarDatabase.isar.pixKeys.put(addedPixKey));
      }
      return;
    }

    final newPixKey = PixKey(
      type: _keyType!,
      value: value,
      description: description,
      bankName: bank!.name,
      bankLogo: bank!.logoAssetName,
    );

    await IsarDatabase.isar
        .writeTxn(() => IsarDatabase.isar.pixKeys.put(newPixKey));
  }
}
