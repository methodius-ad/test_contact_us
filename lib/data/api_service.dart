import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response<dynamic>> fetchData(String name, String email, String message) async {
    try {
     /// TODO: move base url from here to not hardcode and use just endpoint
      final response = await _dio.post('https://api.byteplex.info/api/test/contact/',
      data: {
        "name": name,
        "email": email,
        "message": message
      });
      return response;
    } catch (error, stackTrace) {
      throw Exception("Failed to fetch data: $error"); // Re-throw with more details
    }
  }
}