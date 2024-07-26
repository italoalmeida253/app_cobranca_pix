import 'package:app_cobranca_pix/constants/index.dart';
import 'package:isar/isar.dart';

part 'pix_key.g.dart';

@Collection()
class PixKey {
  Id id = Isar.autoIncrement;
  @enumerated
  PixKeyTypes type;
  String bankName;
  String value;
  String description;

  PixKey({required this.type, required this.bankName, required this.value, required this.description});
}
