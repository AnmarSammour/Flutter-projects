import 'package:ai_palette_generator/models/gradient_alignment_type.dart';
import 'package:ai_palette_generator/models/gradient_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_palette_generator/views/screens/main_wrapper.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ai_palette_generator/controllers/language_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ai_palette_generator/models/color_adapter.dart';
import 'package:ai_palette_generator/models/color_palette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ColorPaletteAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(GradientPaletteAdapter());
  Hive.registerAdapter(GradientAlignmentTypeAdapter());

  await Hive.openBox<ColorPalette>('palettes_box');
  await Hive.openBox<GradientPalette>('gradients_box');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      onGenerateTitle: (context) => AppLocal.of(context).appTitle,

      localizationsDelegates: const [
        AppLocal.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocal.supportedLocales,

      locale: locale,

      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: locale.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
      home: const MainWrapper(),
    );
  }
}
