import 'package:exchange/core/enum_currencies.dart';

class ExchangeState {
  final Currency? fromCurrency;
  final Currency? toCurrency;
  final String? amount;
  final String? result;

  const ExchangeState({
    this.fromCurrency,
    this.toCurrency,
    this.amount,
    this.result,
  });
}

class LoadingState extends ExchangeState {
  const LoadingState({super.fromCurrency, super.toCurrency});
}

class DataState extends ExchangeState {
  const DataState({super.fromCurrency, super.toCurrency, super.amount, super.result});
}
