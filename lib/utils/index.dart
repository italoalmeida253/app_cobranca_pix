import 'dart:convert';

import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:crclib/catalog.dart';

String getBrCode(PixKey pixKey, double? pixValue) {
  late String formattedPixKey;
  String? formattedPixValueLength;
  String? formattedPixValue = pixValue?.toStringAsFixed(2);

  if (formattedPixValue != null) {
    formattedPixValueLength =
        formattedPixValue.length.toString().padLeft(2, '0');
  }

  switch (pixKey.type) {
    case PixKeyTypes.phone:
      formattedPixKey =
          '+55${pixKey.value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')}';
      break;
    case PixKeyTypes.email:
      formattedPixKey = pixKey.value;
      break;
    case PixKeyTypes.cpf:
      formattedPixKey = pixKey.value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
      break;
    case PixKeyTypes.cnpj:
      formattedPixKey = pixKey.value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
      break;
    case PixKeyTypes.randomKey:
      formattedPixKey = pixKey.value;
      break;
  }

  final String brCode =
      '00020126${formattedPixKey.length + 14 + 4 + 4}0014BR.GOV.BCB.PIX01${formattedPixKey.length.toString().padLeft(2, '0')}${formattedPixKey}5204000053039865${formattedPixValueLength != null ? '4$formattedPixValueLength' : ''}${formattedPixValue != null ? '${formattedPixValue}5' : ''}802BR5901N6001C62070503***6304';
  final String crc = calculateBrCodeCrc(brCode);

  return '$brCode$crc';
}

calculateBrCodeCrc(String brCode) {
  List<int> data = utf8.encode(brCode);

  var crcValue =
      Crc16CcittFalse().convert(data).toRadixString(16).toUpperCase();
  return crcValue;
}
