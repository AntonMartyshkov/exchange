import 'package:exchange/core/enum_currencies.dart';
import 'package:exchange/packages/data/currency/currency_model.dart';
import 'package:exchange/packages/domain/local_storage/currency/currency_storage_impl.dart';
import 'package:exchange/packages/domain/local_storage/currency/entity/currency_entity.dart';
import 'package:exchange/packages/domain/network/network.dart';
import 'package:exchange/packages/domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl implements ICurrencyRepository {
  CurrencyRepositoryImpl(this._storage, this._api);

  final CurrencyStorageImpl _storage;
  final CurrencyApi _api;

  @override
  Future<String?> getCurrency({String? currency, String? baseCurrency, String? fromValue}) async {
    try {
      final result = await _api.getCurrencyValue(currency, baseCurrency);
      final currencyValue = result.data[currency];
      return (double.parse(fromValue!) * currencyValue).toString();
    } catch (e) {
      if (currency != null && baseCurrency != null) {
        final currencyValue = await _storage.getCurrency(currency);
        final baseCurrencyValue = await _storage.getCurrency(baseCurrency);
        return (double.parse(fromValue!) * currencyValue!.value / baseCurrencyValue!.value).toString();
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> updateCurrencies() async {
    final result = await _api.getCurrencyValue(null, null);
    for (var curr in Currency.values) {
      final value = result.data[curr.name];

      _storage.saveCurrency(CurrencyEntity().fromModel(
        CurrencyModel(name: curr.name, value: value),
      ));
    }
  }
}
