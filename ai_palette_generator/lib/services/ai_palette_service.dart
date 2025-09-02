import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'api_secrets.dart'; 

class ColorAnalysis {
  final String hex;
  final Color color;
  final String name;
  final String usageSuggestion;
  final List<Color> shades;

  ColorAnalysis({
    required this.hex,
    required this.color,
    required this.name,
    required this.usageSuggestion,
    required this.shades,
  });
}

class ImageAnalysisResult {
  final List<ColorAnalysis> palette;
  final String? logoCritique; 

  ImageAnalysisResult({required this.palette, this.logoCritique});
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
        generationConfig: GenerationConfig(
          maxOutputTokens: 4096, 
        ),
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

  Future<ImageAnalysisResult> getPaletteFromImage({
    required Uint8List imageBytes,
    required String languageCode,
    required String imageType, 
    String? contextDescription,
  }) async {
    final String languageName = languageCode == 'ar' ? 'Arabic' : 'English';

    final String logoCritiquePrompt = imageType == 'logo'
        ? '''
      "logoCritique": {
        "isSuitable": A boolean (true/false) indicating if the image is a good logo.
        "critique": A short, constructive paragraph in **$languageName** that critiques the logo. If it's good, explain why. If it's not (e.g., too complex, poor colors), explain why and provide specific, actionable suggestions for improvement.
      },
    '''
        : '';

    final prompt = TextPart('''
      Analyze this image as an expert brand identity designer and color theorist.
      The user has specified this image is a: **$imageType**.
      ${contextDescription != null && contextDescription.isNotEmpty ? "User context: '$contextDescription'." : ""}

      Your response MUST be a single, valid JSON object with the following structure:
      {
        $logoCritiquePrompt
        "palette": [
          // An array of color analysis objects
        ]
      }

      For the "palette" array, extract the **actual, dominant colors** from the image. For each color, create an object with this structure:
      {
        "hex": The hex color code string.
        "name": A short, descriptive name for the color in **$languageName**.
        "usageSuggestion": A concise, one-sentence suggestion in **$languageName** on how this color could be used in an app UI, considering the user's context if provided.
        "shades": An array of exactly 3 hex strings: a darker shade, the original color, and a lighter tint.
      }

      - **Crucially, if the image type is 'logo'**: Your `logoCritique` must be honest and professional. Assess its simplicity, memorability, and color harmony.
      - Do NOT invent colors. Extract only what is present.
      - The entire response must be valid JSON. Do not include any extra text or markdown.
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

        String? critiqueText;
        if (jsonResponse.containsKey('logoCritique')) {
          critiqueText = jsonResponse['logoCritique']['critique'];
        }

        final List<dynamic> paletteData = jsonResponse['palette'];
        final List<ColorAnalysis> analyzedPalette = paletteData.map((
          colorData,
        ) {
          final List<Color> colorShades = (colorData['shades'] as List)
              .map((hex) => _hexToColor(hex.toString()))
              .toList();

          return ColorAnalysis(
            hex: colorData['hex'],
            color: _hexToColor(colorData['hex']),
            name: colorData['name'],
            usageSuggestion: colorData['usageSuggestion'],
            shades: colorShades,
          );
        }).toList();

        return ImageAnalysisResult(
          palette: analyzedPalette,
          logoCritique: critiqueText,
        );
      } catch (e, s) {
        debugPrint('Error parsing Gemini vision response: $e');
        debugPrint('Stacktrace: $s');
        throw Exception('Failed to parse AI response from image.');
      }
    }

    throw Exception(
      'Failed to get a valid response from the AI model for the image.',
    );
  }
}
