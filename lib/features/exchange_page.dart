import 'package:exchange/core/enum_currencies.dart';
import 'package:exchange/features/cubit/exchange_cubit.dart';
import 'package:exchange/features/cubit/exchange_state.dart';
import 'package:exchange/packages/domain/repositories/currency_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  final TextEditingController fromCurrencyController = TextEditingController();
  final TextEditingController toCurrencyController = TextEditingController();
  ExchangeCubit? cubit;

  @override
  void initState() {
    super.initState();
    cubit = ExchangeCubit(context.read<ICurrencyRepository>())..fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: cubit,
      listener: (context, ExchangeState state) {},
      builder: (context, ExchangeState state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('You send'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: fromCurrencyController,
                        keyboardType: TextInputType.number,
                        onChanged: (v) => cubit?.calculate(v),
                      ),
                    ),
                    Column(
                      children: [
                        if (state.fromCurrency != null) Text(state.fromCurrency!.name),
                        IconButton(
                          onPressed: () => changeCurrencyDialog([state.toCurrency, state.fromCurrency], (c) {
                            cubit?.changeFromCurrency(c);
                            cubit?.calculate(fromCurrencyController.text);
                          }),
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: IconButton(
                      onPressed: () {
                        cubit?.replaceExchanges();
                        final c = fromCurrencyController.text;
                        fromCurrencyController.text = toCurrencyController.text;
                        toCurrencyController.text = c;
                      },
                      icon: const Icon(Icons.currency_exchange)),
                ),
                const Text('They receive'),
                Row(
                  children: [
                    Expanded(
                      child: state.result != null ? Text(state.result!) : const SizedBox(),
                    ),
                    Column(
                      children: [
                        if (state.toCurrency != null) Text(state.toCurrency!.name),
                        IconButton(
                          onPressed: () => changeCurrencyDialog([state.toCurrency, state.fromCurrency], (c) {
                            cubit?.changeToCurrency(c);
                          }),
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void changeCurrencyDialog(List<Currency?> selectedCurrency, Function(Currency) onCurrencySelected) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: Currency.values
                .map((e) => !selectedCurrency.contains(e)
                    ? ListTile(
                        title: Text(e.name),
                        onTap: () {
                          onCurrencySelected.call(e);
                          Navigator.pop(context);
                        },
                      )
                    : const SizedBox())
                .toList(),
          ),
        ),
      ),
    );
  }
}
