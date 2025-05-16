import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/core/netwrok/api_consumer.dart';
import 'package:news_app/core/netwrok/interceptors.dart';

class DioConsumer implements ApiConsumer {
  final  baseurl =dotenv.env['BASE_URL'];
  final String apikey =dotenv.env['API_KEY'].toString();
  DioConsumer({required this.client}) {
    client.options
      ..baseUrl = baseurl!
      ..responseType = ResponseType.json
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15);

    client.interceptors.add(AppInterceptors());
  }
  final Dio client;

  @override
  Future<dynamic> get(
    String path ,{
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final updatedQueryParameters = {
        'apiKey': apikey,
        'from': '2025-05-04',
        'sortBy': 'publishedAt',
        ...?queryParameters,
      };
          final uri = Uri.parse('${client.options.baseUrl}$path')
        .replace(queryParameters: updatedQueryParameters);
        log('📡 [GET] Requesting URL: $uri'); // 👈 logs full URL

      final response = await client.get(path, queryParameters: updatedQueryParameters);
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('Connection timed out');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection');
      case DioExceptionType.unknown:
      default:
        return Exception('Unexpected error: ${error.message}');
    }
  }
}
