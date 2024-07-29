import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/models/bank.dart';
import 'package:isar/isar.dart';

part 'pix_key.g.dart';

@Collection()
class PixKey {
  Id id = Isar.autoIncrement;
  String value;
  String description;
  String bankName;
  String bankLogo;

  @enumerated
  PixKeyTypes type;

  PixKey(
      {required this.type,
      required this.value,
      required this.description,
      required this.bankName,
      required this.bankLogo});
}
