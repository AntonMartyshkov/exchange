import 'package:dio/dio.dart';
import 'package:exchange/packages/domain/network/core/rest_client.dart';
import 'package:exchange/packages/domain/network/currency/dto/response_wrapper.dart';
import 'package:retrofit/retrofit.dart';

part 'currency_api.g.dart';

@RestApi()
abstract class CurrencyApi {
  factory CurrencyApi(RestClient rest) => _CurrencyApi(rest.client);

  @GET('latest')
  Future<ResponseWrapper> getCurrencyValue(
    @Query('currencies') String? currencies,
    @Query('base_currency') String? baseCurrency,
  );
}
