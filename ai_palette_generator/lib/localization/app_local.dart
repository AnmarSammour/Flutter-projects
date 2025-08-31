import 'package:flutter/material.dart';

class AppLocal {
  final Locale locale;

  AppLocal(this.locale);

  static AppLocal of(BuildContext context) {
    return Localizations.of<AppLocal>(context, AppLocal)!;
  }

  static const supportedLocales = [Locale('ar'), Locale('en')];

  static const LocalizationsDelegate<AppLocal> delegate = _AppLocalDelegate();

  static final Map<String, String> _ar = {
    'appTitle': 'مولد لوحات الألوان الذكي',
    'navHome': 'الرئيسية',
    'navGenerate': 'إنشاء',
    'navFavorites': 'المفضلة',
    'navSettings': 'الإعدادات',
    'homeGeneratePaletteTitle': 'إنشاء لوحة',
    'homeGeneratePaletteSubtitle': 'من الصفر أو من لون',
    'homeUploadImageTitle': 'رفع صورة',
    'homeUploadImageSubtitle': 'استخراج من شعار',
    'homeFavoritesTitle': 'المفضلة',
    'homeFavoritesSubtitle': 'لوحاتك المحفوظة',
  };

  static final Map<String, String> _en = {
    'appTitle': 'AI Palette Generator',
    'navHome': 'Home',
    'navGenerate': 'Generate',
    'navFavorites': 'Favorites',
    'navSettings': 'Settings',
    'homeGeneratePaletteTitle': 'Generate Palette',
    'homeGeneratePaletteSubtitle': 'From scratch or color',
    'homeUploadImageTitle': 'Upload Image',
    'homeUploadImageSubtitle': 'Extract from a logo',
    'homeFavoritesTitle': 'Favorites',
    'homeFavoritesSubtitle': 'Your saved palettes',
  };

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': _ar,
    'en': _en,
  };

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get navHome => _localizedValues[locale.languageCode]!['navHome']!;
  String get navGenerate =>
      _localizedValues[locale.languageCode]!['navGenerate']!;
  String get navFavorites =>
      _localizedValues[locale.languageCode]!['navFavorites']!;
  String get navSettings =>
      _localizedValues[locale.languageCode]!['navSettings']!;
  String get homeGeneratePaletteTitle =>
      _localizedValues[locale.languageCode]!['homeGeneratePaletteTitle']!;
  String get homeGeneratePaletteSubtitle =>
      _localizedValues[locale.languageCode]!['homeGeneratePaletteSubtitle']!;
  String get homeUploadImageTitle =>
      _localizedValues[locale.languageCode]!['homeUploadImageTitle']!;
  String get homeUploadImageSubtitle =>
      _localizedValues[locale.languageCode]!['homeUploadImageSubtitle']!;
  String get homeFavoritesTitle =>
      _localizedValues[locale.languageCode]!['homeFavoritesTitle']!;
  String get homeFavoritesSubtitle =>
      _localizedValues[locale.languageCode]!['homeFavoritesSubtitle']!;
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocal> {
  const _AppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocal.supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocal> load(Locale locale) async {
    return AppLocal(locale);
  }

  @override
  bool shouldReload(_AppLocalDelegate old) => false;
}
