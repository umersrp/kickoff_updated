import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VendorHttpHelper {
  /// base url
  static const String baseUrl = 'http://74.208.118.86/kickoff/api';

  /// get token
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken') ?? '';

    log('Token: $token');
    return token;
  }

  /// GET
  static Future<Map<String, dynamic>> get(String endPoints) async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/$endPoints'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return _handleResponse(response);
  }

  /// POST
  static Future<Map<String, dynamic>> post(
      String endPoints, dynamic data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endPoints'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  static Future<http.Response> post2(String endPoints, dynamic data) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/$endPoints'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': '$token',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    return response;
  }

  /// DELETE
  static Future<Map<String, dynamic>> delete(String endPoints) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endPoints'));
    return _handleResponse(response);
  }

  /// UPDATE
  static Future<Map<String, dynamic>> put(
      String endPoints, dynamic data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endPoints'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Habdle The HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
}
