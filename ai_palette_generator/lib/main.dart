// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_palette_generator/views/screens/main_wrapper.dart';

void main() {
  // سنضيف هنا تهيئة Hive لاحقاً
  runApp(
    // ProviderScope ضروري لعمل Riverpod
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Palette Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith( 
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainWrapper(),
    );
  }
}
