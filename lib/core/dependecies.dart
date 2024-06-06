import 'package:exchange/packages/domain/local_storage/core/database.dart';
import 'package:exchange/packages/domain/network/core/rest_client.dart';

class AppDependencies {
  AppDependencies();
  late DataBase db;
  late RestClient restClient;

  Future<void> init() async {
    db = DataBase();
    await db.init();
    restClient = RestClient();
  }
}
