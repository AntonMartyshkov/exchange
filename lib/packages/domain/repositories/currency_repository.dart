abstract class ICurrencyRepository {
  Future<String?> getCurrency({String? currency, String? baseCurrency, String? fromValue});
  Future<void> updateCurrencies();
}
