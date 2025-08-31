import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to store the current language (Locale)
final localeProvider = StateProvider<Locale>((ref) {
  // The default language is Arabic
  return const Locale('ar');
});
