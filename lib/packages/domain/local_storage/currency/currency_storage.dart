import 'package:exchange/packages/domain/local_storage/currency/entity/currency_entity.dart';

abstract class ICurrencyStorage {
  Future<CurrencyEntity?> getCurrency(String currency);
  Future<void> saveCurrency(CurrencyEntity currency);
}
