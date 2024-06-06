import 'package:exchange/core/dependecies.dart';
import 'package:exchange/features/exchange_page.dart';
import 'package:exchange/packages/domain/local_storage/currency/currency_storage_impl.dart';
import 'package:exchange/packages/domain/network/currency/currency_api.dart';
import 'package:exchange/packages/domain/repositories/currency_repository.dart';
import 'package:exchange/packages/domain/repositories/currency_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({required this.appDependencies, super.key});

  final AppDependencies appDependencies;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<ICurrencyRepository>(
            create: (context) => CurrencyRepositoryImpl(
                  CurrencyStorageImpl(appDependencies.db.database),
                  CurrencyApi(appDependencies.restClient),
                )),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const ExchangePage(),
      ),
    );
  }
}
