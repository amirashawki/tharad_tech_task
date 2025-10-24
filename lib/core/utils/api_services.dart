import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  final _baseUrl = 'https://evolvify.runasp.net/api/';
  final Dio _dio = Dio();

  Future<String?> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>> post({required String endPoint, data}) async {
    final token = await _loadToken();

    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    final token = await _loadToken();

    final response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return response.data;
  }
}
