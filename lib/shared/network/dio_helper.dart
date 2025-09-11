// Dio helper class for making HTTP requests using the Dio package, including initialization and a method for GET requests
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  // Initialize Dio with base options like base URL and error handling
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // Method to perform GET requests with optional query parameters, language, and token for authorization
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.get(url, queryParameters: query ?? null);
  }
}
