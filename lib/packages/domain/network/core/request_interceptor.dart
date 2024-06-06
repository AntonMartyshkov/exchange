import 'package:dio/dio.dart';
import 'package:exchange/packages/domain/network/core/constants.dart';

class RequestApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'apiKey': Constants.API_KEY});
    handler.next(options);
  }
}
