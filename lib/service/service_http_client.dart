import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseUrl = 'http://10.0.0.2:8000/api/';

  final secureStorage = FlutterSecureStorage();

  // POST
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("Post request failed: $e");
    }
  }

  // GET
  Future<http.Response> get(String endpoint) async {
    final token = await secureStorage.read(key: "token");
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.get(
        url,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }
      );
      return response;
    } catch (e) {
      throw Exception("Get request failed: $e");
    }
  }

  Future<http.Response> postWihToken(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endPoint");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      _logRequest("POST", url, body, response);
      return response;
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  void _logRequest(
    String method,
    Uri url,
    Map<String, dynamic>? body,
    http.Response response,
  ) {
    print("==== HTTP REQUEST ====");
    print("Method: $method");
    print("URL: $url");
    if (body != null) print("Body: ${jsonEncode(body)}");
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    print("======================");
  }
}