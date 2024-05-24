import 'dart:convert';
import 'dart:developer';

import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/models/exam_bank.dart';
import 'package:fisimate/app/models/formula_bank.dart';
import 'package:fisimate/app/models/material_bank.dart';
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

    final result = jsonDecode(response.body)['data']['access_token'];

    return result;
  }

  static Future<http.Response> logout(
      {required String accessToken, required String refreshToken}) async {
    final url = Uri.parse(URLs.baseUrl + URLs.logout);

    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      getAccessToken(refreshToken: refreshToken);
      logout(accessToken: accessToken, refreshToken: refreshToken);
    }

    return response;
  }

  static Future<MaterialBank> getMaterialBanks({
    required String accessToken,
    required String refreshToken,
  }) async {
    final url = Uri.parse(URLs.baseUrl + URLs.materialBank);

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)['data'];

      log('Json Response on Material Bank: $jsonResponse');

      return materialBankFromJson(jsonEncode(jsonResponse));
    } else if (response.statusCode == 401) {
      getAccessToken(refreshToken: refreshToken);
      getMaterialBanks(accessToken: accessToken, refreshToken: refreshToken);
    } else {
      throw Exception('Failed to load Material Bank');
    }

    return materialBankFromJson(jsonEncode({}));
  }

  static Future<List<FormulaBank>> getFormulaBanks(
      {required String accessToken}) async {
    final url = Uri.parse(URLs.baseUrl + URLs.formulaBank);

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)["data"]["result"];
      log("formula + $jsonResponse");
      return formulaBankFromJson(jsonEncode(jsonResponse));
    } else {
      throw Exception('Failed to load Formula Bank');
    }
  }

  static Future<List<ExamBank>> getExamBanks(
      {required String accessToken}) async {
    final url = Uri.parse(URLs.baseUrl + URLs.examBank);

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)["data"]["result"];
      log("exam + $jsonResponse");
      return examBankFromJson(jsonEncode(jsonResponse));
    } else {
      throw Exception('Failed to load Exam Bank');
    }
  }
}
