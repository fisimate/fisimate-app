import 'dart:convert';
import 'dart:developer';

import 'package:fisimate/app/config/api/urls.dart';
import 'package:http/http.dart' as http;

abstract class ApiService {
  static Future<http.Response> login(
      {required String email, required String password}) async {
    final url = Uri.parse(URLs.baseUrl + URLs.login);

    final body = {
      'email': email,
      'password': password,
    };

    log('Login url: $url');

    final response = await http.post(url, body: body);

    return response;
  }

  static Future<http.Response> register(
      {required String fullname,
      required String nis,
      required String email,
      required String password,
      required String passwordConfirmation}) async {
    final url = Uri.parse(URLs.baseUrl + URLs.register);

    final body = {
      'fullname': fullname,
      'nis': nis,
      'email': email,
      'password': password,
      'passwordConfirmation': passwordConfirmation
    };

    log('Register url: $url');

    final response = await http.post(url, body: body);

    return response;
  }

  static bool isTokenValid(
      {required String accessToken, required String refreshToken}) {
    if (accessToken == refreshToken) {
      return true;
    }
    return false;
  }

  static Future<String> getAccessToken({required String refreshToken}) async {
    final url = Uri.parse('${URLs.baseUrl}${URLs.refreshToken}/$refreshToken');

    final response = await http.get(url);

    final jsonResponse = jsonDecode(response.body);

    return jsonResponse['data']['access_token'];
  }

  static Future<http.Response> logout({required String accessToken}) async {
    final url = Uri.parse(URLs.baseUrl + URLs.logout);

    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    return response;
  }
}
