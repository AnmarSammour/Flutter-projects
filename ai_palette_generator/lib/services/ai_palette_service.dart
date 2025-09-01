import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'api_secrets.dart';

class AiPaletteService {
  final GenerativeModel _model;

  AiPaletteService()
    : _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: geminiApiKey);

  Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Future<List<Color>> getPaletteFromDescription(
    String description,
    int colorCount,
  ) async {
    final prompt =
        '''
      Act as an expert color palette designer.
      Based on the following description, generate a harmonious color palette with exactly $colorCount colors.
      The description is: "$description".

      Your response MUST be a valid JSON array of strings, where each string is a hex color code.
      Do not include any other text, explanations, or markdown.
      Example response for 2 colors: ["#FF5733", "#33FF57"]
    ''';

    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);

    if (response.text != null) {
      try {
        final responseText = response.text!;

        final cleanedJsonString = responseText
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();

        if (cleanedJsonString.isNotEmpty) {
          final List<dynamic> hexCodes = json.decode(cleanedJsonString);

          final colors = hexCodes
              .map((hex) => _hexToColor(hex.toString()))
              .toList();
          return colors;
        }
      } catch (e) {
        debugPrint('Error parsing Gemini response: $e');
        throw Exception(
          'Failed to parse AI response. The model might have returned an unexpected format.',
        );
      }
    }

    throw Exception('Failed to get a valid response from the AI model.');
  }
}
