import 'package:dio/dio.dart';
import 'package:exchange/packages/domain/network/core/request_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RestClient {
  RestClient() : _dio = Dio() {
    _dio.options = BaseOptions(baseUrl: _baseUrl);
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(RequestApiKeyInterceptor());
  }

  final Dio _dio;
  get client => _dio;
  final String _baseUrl = 'https://api.freecurrencyapi.com/v1/';
  get baseUrl => _baseUrl;
}
