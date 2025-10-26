import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  final _baseUrl = 'https://flutter.tharadtech.com/api/';
  final Dio _dio = Dio();

  Future<String?> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? token,
  }) async {
    token ??= await _loadToken();
    final response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    data,
    bool isFormData = false,
  }) async {
    final token = await _loadToken();

    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: isFormData ? FormData.fromMap(data) : data,
      options: Options(
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return response.data;
  }

  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.delete(endPoint, options: Options(headers: headers));
  }
}
