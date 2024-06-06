import 'package:exchange/packages/domain/local_storage/currency/entity/currency_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DataBase {
  static Isar? _database;
  get database => _database;

  Future<void> init() async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    const dbName = Isar.defaultName;

    if (_database == null) {
      if (Isar.getInstance(dbName) == null || !Isar.getInstance(dbName)!.isOpen) {
        _database = await Isar.open(
          [
            CurrencyEntitySchema,
          ],
          name: dbName,
          directory: dir,
        );
      } else {
        _database = Isar.getInstance(dbName);
      }
    }
  }
}
