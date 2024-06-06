import 'dart:async';

import 'package:exchange/core/enum_currencies.dart';
import 'package:exchange/features/cubit/exchange_state.dart';
import 'package:exchange/packages/domain/repositories/currency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  ExchangeCubit(this.repository) : super(const LoadingState());
  ICurrencyRepository repository;

  Timer? debounceTimer;

  fetchData() async {
    emit(const LoadingState(toCurrency: Currency.EUR, fromCurrency: Currency.RUB));
    await repository.updateCurrencies();
    emit(DataState(fromCurrency: state.fromCurrency, toCurrency: state.toCurrency));
  }

  changeFromCurrency(Currency cur) {
    emit(DataState(fromCurrency: cur, toCurrency: state.toCurrency));
  }

  changeToCurrency(Currency cur) {
    emit(DataState(toCurrency: cur, fromCurrency: state.fromCurrency));
  }

  replaceExchanges() {
    emit(DataState(fromCurrency: state.toCurrency, toCurrency: state.fromCurrency));
  }

  calculate(String fromValue) async {
    if (state.toCurrency == null || state.fromCurrency == null) {
      return;
    }
    debounceTimer?.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      final result = await repository.getCurrency(
        currency: state.toCurrency?.name,
        baseCurrency: state.fromCurrency?.name,
        fromValue: fromValue,
      );
      emit(DataState(
        fromCurrency: state.fromCurrency,
        toCurrency: state.toCurrency,
        result: result,
      ));
    });
  }
}
