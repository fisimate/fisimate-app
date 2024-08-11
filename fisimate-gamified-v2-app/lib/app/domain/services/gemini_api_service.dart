import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:logger/logger.dart';

class GeminiApiService {
  static Future<String?> stringFromGemini({
    required String prompt,
  }) async {
    print('Prompt: $prompt');
    print('Gemini API Key: ${dotenv.env['GEMINI_API_KEY']}');

    final model = GenerativeModel(
      model: "gemini-1.5-flash-latest",
      apiKey: dotenv.env['GEMINI_API_KEY']!,
    );

    Logger logger = Logger();

    final String stringExamTemplate = await rootBundle.loadString(
      "assets/json/exam_template.json",
    );

    final promptString =
        '(Hanya respon dengan format JSON) dengan template $stringExamTemplate (pastikan hanya ada satu jawaban benar): Buatkan soal Fisika Kelas 7 SMP dengan bab $prompt';
    final content = [
      Content.text(promptString),
    ];
    final response = await model.generateContent(content);
    logger.i(response.text);
    return response.text ?? '';
  }

  static Map<String, dynamic> parseFromString({
    required String stringFromGeminiResponse,
  }) {
    int startIndex = stringFromGeminiResponse.indexOf('{');
    int endIndex = stringFromGeminiResponse.lastIndexOf('}');

    if (startIndex != -1 && endIndex != -1) {
      String jsonSubstring =
          stringFromGeminiResponse.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonObject = json.decode(jsonSubstring);
      return jsonObject;
    } else {
      return {};
    }
  }
}
