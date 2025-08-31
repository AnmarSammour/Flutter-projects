// lib/localization/app_local.dart
import 'package:flutter/material.dart';

class AppLocal {
  final Locale locale;

  AppLocal(this.locale);

  static AppLocal of(BuildContext context) {
    return Localizations.of<AppLocal>(context, AppLocal)!;
  }

  static const supportedLocales = [Locale('ar'), Locale('en')];

  static const LocalizationsDelegate<AppLocal> delegate = _AppLocalDelegate();

  // --- ARABIC ---
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
    'generateScreenTitle': 'إنشاء لوحة ألوان',
    'baseColorLabel': 'اللون الأساسي (اختياري)',
    'pickColorButton': 'اختر لون',
    'savePaletteButton': 'حفظ اللوحة',
    'paletteSaved': 'تم حفظ اللوحة في المفضلة!',
    'colorCountLabel': 'عدد الألوان',
    'refreshButton': 'تحديث',
    'copiedToClipboard': 'تم نسخ الكود: ',
    'errorFailedToLoad': 'حدث خطأ في جلب اللوحة',
    'settingsScreenTitle': 'الإعدادات',
    'languageLabel': 'اللغة',
    'arabic': 'العربية',
    'english': 'الإنجليزية',
  };

  // --- ENGLISH ---
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
    'generateScreenTitle': 'Generate Color Palette',
    'baseColorLabel': 'Base Color (Optional)',
    'pickColorButton': 'Pick a Color',
    'savePaletteButton': 'Save Palette',
    'paletteSaved': 'Palette saved to favorites!',
    'colorCountLabel': 'Number of Colors',
    'refreshButton': 'Refresh',
    'copiedToClipboard': 'Copied to clipboard: ',
    'errorFailedToLoad': 'Failed to load palette',
    'settingsScreenTitle': 'Settings',
    'languageLabel': 'Language',
    'arabic': 'Arabic',
    'english': 'English',
  };

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': _ar,
    'en': _en,
  };

  // --- Getters ---
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
  String get generateScreenTitle =>
      _localizedValues[locale.languageCode]!['generateScreenTitle']!;
  String get baseColorLabel =>
      _localizedValues[locale.languageCode]!['baseColorLabel']!;
  String get pickColorButton =>
      _localizedValues[locale.languageCode]!['pickColorButton']!;
  String get savePaletteButton =>
      _localizedValues[locale.languageCode]!['savePaletteButton']!;
  String get paletteSaved =>
      _localizedValues[locale.languageCode]!['paletteSaved']!;
  String get colorCountLabel =>
      _localizedValues[locale.languageCode]!['colorCountLabel']!;
  String get refreshButton =>
      _localizedValues[locale.languageCode]!['refreshButton']!;
  String get copiedToClipboard =>
      _localizedValues[locale.languageCode]!['copiedToClipboard']!;
  String get errorFailedToLoad =>
      _localizedValues[locale.languageCode]!['errorFailedToLoad']!;
  String get settingsScreenTitle =>
      _localizedValues[locale.languageCode]!['settingsScreenTitle']!;
  String get languageLabel =>
      _localizedValues[locale.languageCode]!['languageLabel']!;
  String get arabic => _localizedValues[locale.languageCode]!['arabic']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
}

// Delegate class (no changes needed here)
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
