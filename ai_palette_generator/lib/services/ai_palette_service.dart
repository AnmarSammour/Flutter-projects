import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'api_secrets.dart';

class ImageAnalysisResult {
  final List<Color> palette;
  final String analysis;

  ImageAnalysisResult({required this.palette, required this.analysis});
}

class AiPaletteService {
  final GenerativeModel _textModel;
  final GenerativeModel _visionModel;

  AiPaletteService()
    : _textModel = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: geminiApiKey,
      ),
      _visionModel = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: geminiApiKey,
      );

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
    final response = await _textModel.generateContent(content);

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
        debugPrint('Error parsing Gemini text response: $e');
        throw Exception('Failed to parse AI response from text.');
      }
    }
    throw Exception(
      'Failed to get a valid response from the AI model for text.',
    );
  }

  Future<ImageAnalysisResult> getPaletteFromImage(
    Uint8List imageBytes, {
    required String languageCode,
  }) async {
    final String languageName = languageCode == 'ar' ? 'Arabic' : 'English';

    final prompt = TextPart('''
      Analyze this image as an expert UI/UX designer. Your task is to generate a harmonious 5-color palette suitable for a mobile app, based on the image's content, mood, and subject.

      Your response MUST be a single, valid JSON object with two keys:
      1. "palette": An array of exactly 5 strings, where each string is a hex color code.
      2. "analysis": A short, one-paragraph string written in **$languageName** explaining why you chose these colors and how they can be used (e.g., for primary buttons, background, text).

      Example response if the language is English:
      {
        "palette": ["#1A2B3C", "#D4E5F6", "#FFC107", "#607D8B", "#FFFFFF"],
        "analysis": "This palette was chosen to reflect the professional atmosphere in the image. The dark blue is ideal as a primary color for buttons, while white provides a clean background. The yellow acts as an accent to draw attention."
      }
    ''');

    final imagePart = DataPart('image/jpeg', imageBytes);

    final response = await _visionModel.generateContent([
      Content.multi([prompt, imagePart]),
    ]);

    if (response.text != null) {
      try {
        final responseText = response.text!;
        final cleanedJsonString = responseText
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();
        final Map<String, dynamic> jsonResponse = json.decode(
          cleanedJsonString,
        );

        final List<dynamic> hexCodes = jsonResponse['palette'];
        final String analysisText = jsonResponse['analysis'];

        final colors = hexCodes
            .map((hex) => _hexToColor(hex.toString()))
            .toList();

        return ImageAnalysisResult(palette: colors, analysis: analysisText);
      } catch (e) {
        debugPrint('Error parsing Gemini vision response: $e');
        throw Exception('Failed to parse AI response from image.');
      }
    }

    throw Exception(
      'Failed to get a valid response from the AI model for the image.',
    );
  }
}
