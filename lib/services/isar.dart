import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([PixKeySchema], directory: dir.path);
  }

  static Stream<List<PixKey>> listenPixKeys() async* {
    yield* isar.pixKeys.where().watch(fireImmediately: true);
  }
}
