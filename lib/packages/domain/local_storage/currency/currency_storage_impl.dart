import 'package:exchange/packages/domain/local_storage/currency/currency_storage.dart';
import 'package:exchange/packages/domain/local_storage/currency/entity/currency_entity.dart';
import 'package:isar/isar.dart';

class CurrencyStorageImpl implements ICurrencyStorage {
  final Isar _isar;

  CurrencyStorageImpl(this._isar);

  @override
  Future<CurrencyEntity?> getCurrency(String currency) {
    return _isar.currencyEntitys.where().filter().nameEqualTo(currency).findFirst();
  }

  @override
  Future<void> saveCurrency(CurrencyEntity currency) {
    return _isar.writeTxn(() async {
      await _isar.currencyEntitys.put(currency);
    });
  }
}
