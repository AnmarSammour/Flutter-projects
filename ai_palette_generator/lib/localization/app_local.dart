import 'package:flutter/material.dart';

class AppLocal {
  final Locale locale;
  AppLocal(this.locale);

  static AppLocal of(BuildContext context) =>
      Localizations.of<AppLocal>(context, AppLocal)!;
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
    'homeGeneratePaletteSubtitle': 'من الصفر، لون، أو وصف',
    'homeUploadImageTitle': 'رفع صورة',
    'homeUploadImageSubtitle': 'استخراج من شعار',
    'homeFavoritesTitle': 'المفضلة',
    'homeFavoritesSubtitle': 'لوحاتك المحفوظة',
    'generateScreenTitle': 'إنشاء لوحة ألوان',
    'colorCountLabel': 'عدد الألوان',
    'refreshButton': 'تحديث عشوائي',
    'copiedToClipboard': 'تم نسخ الكود: ',
    'errorFailedToLoad': 'حدث خطأ في جلب اللوحة',
    'settingsScreenTitle': 'الإعدادات',
    'languageLabel': 'اللغة',
    'arabic': 'العربية',
    'english': 'الإنجليزية',
    'baseColorLabel': 'اللون الأساسي',
    'pickColorButton': 'اختر لون',
    'savePaletteButton': 'حفظ اللوحة',
    'paletteSaved': 'تم حفظ اللوحة في المفضلة!',
    'favoritesEmptyTitle': 'المفضلة فارغة',
    'favoritesEmptySubtitle': 'ابدأ بحفظ لوحات الألوان التي تعجبك لتجدها هنا.',
    'removeFavoriteTooltip': 'إزالة من المفضلة',
    'copiedMessage': 'تم نسخ: ',
    'industryContextTitle': 'ألوان حسب الصناعة',
    'industryHintText': 'اختر نوع التطبيق...',
    'industryIslamic': 'إسلامي / روحاني',
    'industryEducational': 'تعليمي / أطفال',
    'industryBanking': 'بنكي / مالي',
    'industryTech': 'تقني / شركات',
    'industryHealth': 'صحي / طبي',
    'industryFood': 'طعام / مطاعم',
    'aiDescriptionLabel': 'أو صف تصميمك (AI)',
    'aiDescriptionHint': 'مثال: غروب الشمس على الشاطئ...',
    'generateFromDescription': 'ولّد من الوصف',
    'uploadScreenTitle': 'استخراج الألوان من صورة',
    'uploadSelectImage': 'اختر صورة من المعرض',
    'uploadTakePhoto': 'التقط صورة بالكاميرا',
    'uploadInstructions': 'اختر صورة لتحليلها واستخراج لوحة ألوان مميزة منها.',
    'uploadAnalyzing': 'جاري تحليل الصورة...',
    'uploadError': 'حدث خطأ أثناء معالجة الصورة.',
    'dominantColor': 'اللون الأساسي المقترح',
    'extractedColors': 'لوحة الألوان المستخرجة',
    'suggestedPalette': 'تحليل الذكاء الاصطناعي',
    'primary': 'اللون الأساسي (للعناصر الهامة)',
    'secondary': 'اللون الثانوي (للعناصر الداعمة)',
    'background': 'لون الخلفية (للمساحات الفارغة)',
    'accent': 'لون مميز (للفت الانتباه)',
    'homeGradientGeneratorTitle': 'إنشاء تدرج',
    'homeGradientGeneratorSubtitle': 'تدرجات خطية وشعاعية',
    'gradientScreenTitle': 'مولد التدرجات اللونية',
    'gradientColors': 'الألوان',
    'gradientType': 'نوع التدرج',
    'gradientLinear': 'خطي',
    'gradientRadial': 'شعاعي',
    'gradientAddColor': 'إضافة لون',
    'gradientRemoveColor': 'إزالة اللون',
    'gradientPreview': 'معاينة',
    'gradientAlignment': 'اتجاه التدرج',
    'gradientSave': 'حفظ التدرج',
    'gradientCopyCode': 'نسخ كود CSS',
    'gradientCodeCopied': 'تم نسخ كود CSS للتدرج!',
    'gradientSaved': 'تم حفظ التدرج في المفضلة!',
    'alignLinear': 'خطي',
    'alignRadial': 'شعاعي',
    'alignLinearLeftRight': 'خطي (من اليسار لليمين)',
    'alignLinearTopBottom': 'خطي (من الأعلى للأسفل)',
    'alignLinearTopLeftBottomRight': 'خطي (مائل من الأعلى يسار)',
    'alignLinearBottomLeftTopRight': 'خطي (مائل من الأسفل يسار)',
  };

  // --- ENGLISH ---
  static final Map<String, String> _en = {
    'appTitle': 'AI Palette Generator',
    'navHome': 'Home',
    'navGenerate': 'Generate',
    'navFavorites': 'Favorites',
    'navSettings': 'Settings',
    'homeGeneratePaletteTitle': 'Generate Palette',
    'homeGeneratePaletteSubtitle': 'From scratch, color, or text',
    'homeUploadImageTitle': 'Upload Image',
    'homeUploadImageSubtitle': 'Extract from a logo',
    'homeFavoritesTitle': 'Favorites',
    'homeFavoritesSubtitle': 'Your saved palettes',
    'generateScreenTitle': 'Generate Color Palette',
    'colorCountLabel': 'Number of Colors',
    'refreshButton': 'Random Refresh',
    'copiedToClipboard': 'Copied to clipboard: ',
    'errorFailedToLoad': 'Failed to load palette',
    'settingsScreenTitle': 'Settings',
    'languageLabel': 'Language',
    'arabic': 'Arabic',
    'english': 'English',
    'baseColorLabel': 'Base Color',
    'pickColorButton': 'Pick a Color',
    'savePaletteButton': 'Save Palette',
    'paletteSaved': 'Palette saved to favorites!',
    'favoritesEmptyTitle': 'Favorites is Empty',
    'favoritesEmptySubtitle':
        'Start saving palettes you like to find them here.',
    'removeFavoriteTooltip': 'Remove from favorites',
    'copiedMessage': 'Copied: ',
    'industryContextTitle': 'Palettes by Industry',
    'industryHintText': 'Select app type...',
    'industryIslamic': 'Islamic / Spiritual',
    'industryEducational': 'Educational / Kids',
    'industryBanking': 'Banking / Finance',
    'industryTech': 'Tech / Corporate',
    'industryHealth': 'Health / Medical',
    'industryFood': 'Food / Restaurant',
    'aiDescriptionLabel': 'Or describe your design (AI)',
    'aiDescriptionHint': 'e.g., sunset on a beach...',
    'generateFromDescription': 'Generate from Description',
    'uploadScreenTitle': 'Extract Colors from Image',
    'uploadSelectImage': 'Select from Gallery',
    'uploadTakePhoto': 'Take a Photo',
    'uploadInstructions':
        'Choose an image to analyze and extract a unique color palette.',
    'uploadAnalyzing': 'Analyzing image...',
    'uploadError': 'An error occurred while processing the image.',
    'dominantColor': 'Dominant Color',
    'extractedColors': 'Extracted Colors',
    'suggestedPalette': 'Suggested App Palette',
    'primary': 'Primary',
    'secondary': 'Secondary',
    'background': 'Background',
    'accent': 'Accent',
    'homeGradientGeneratorTitle': 'Create Gradient',
    'homeGradientGeneratorSubtitle': 'Linear & radial gradients',
    'gradientScreenTitle': 'Gradient Generator',
    'gradientColors': 'Colors',
    'gradientType': 'Gradient Type',
    'gradientLinear': 'Linear',
    'gradientRadial': 'Radial',
    'gradientAddColor': 'Add Color',
    'gradientRemoveColor': 'Remove Color',
    'gradientPreview': 'Preview',
    'gradientAlignment': 'Gradient Alignment',
    'gradientSave': 'Save Gradient',
    'gradientCopyCode': 'Copy CSS Code',
    'gradientCodeCopied': 'CSS Gradient code copied!',
    'gradientSaved': 'Gradient saved to favorites!',
    'alignLinear': 'Linear',
    'alignRadial': 'Radial',
    'alignLinearLeftRight': 'Linear (Left to Right)',
    'alignLinearTopBottom': 'Linear (Top to Bottom)',
    'alignLinearTopLeftBottomRight': 'Linear (Top-Left to Bottom-Right)',
    'alignLinearBottomLeftTopRight': 'Linear (Bottom-Left to Top-Right)',
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
  String get baseColorLabel =>
      _localizedValues[locale.languageCode]!['baseColorLabel']!;
  String get pickColorButton =>
      _localizedValues[locale.languageCode]!['pickColorButton']!;
  String get savePaletteButton =>
      _localizedValues[locale.languageCode]!['savePaletteButton']!;
  String get paletteSaved =>
      _localizedValues[locale.languageCode]!['paletteSaved']!;
  String get favoritesEmptyTitle =>
      _localizedValues[locale.languageCode]!['favoritesEmptyTitle']!;
  String get favoritesEmptySubtitle =>
      _localizedValues[locale.languageCode]!['favoritesEmptySubtitle']!;
  String get removeFavoriteTooltip =>
      _localizedValues[locale.languageCode]!['removeFavoriteTooltip']!;
  String get copiedMessage =>
      _localizedValues[locale.languageCode]!['copiedMessage']!;
  String get industryContextTitle =>
      _localizedValues[locale.languageCode]!['industryContextTitle']!;
  String get industryHintText =>
      _localizedValues[locale.languageCode]!['industryHintText']!;
  String get industryIslamic =>
      _localizedValues[locale.languageCode]!['industryIslamic']!;
  String get industryEducational =>
      _localizedValues[locale.languageCode]!['industryEducational']!;
  String get industryBanking =>
      _localizedValues[locale.languageCode]!['industryBanking']!;
  String get industryTech =>
      _localizedValues[locale.languageCode]!['industryTech']!;
  String get industryHealth =>
      _localizedValues[locale.languageCode]!['industryHealth']!;
  String get industryFood =>
      _localizedValues[locale.languageCode]!['industryFood']!;
  String get aiDescriptionLabel =>
      _localizedValues[locale.languageCode]!['aiDescriptionLabel']!;
  String get aiDescriptionHint =>
      _localizedValues[locale.languageCode]!['aiDescriptionHint']!;
  String get generateFromDescription =>
      _localizedValues[locale.languageCode]!['generateFromDescription']!;
  String get uploadScreenTitle =>
      _localizedValues[locale.languageCode]!['uploadScreenTitle']!;
  String get uploadSelectImage =>
      _localizedValues[locale.languageCode]!['uploadSelectImage']!;
  String get uploadTakePhoto =>
      _localizedValues[locale.languageCode]!['uploadTakePhoto']!;
  String get uploadInstructions =>
      _localizedValues[locale.languageCode]!['uploadInstructions']!;
  String get uploadAnalyzing =>
      _localizedValues[locale.languageCode]!['uploadAnalyzing']!;
  String get uploadError =>
      _localizedValues[locale.languageCode]!['uploadError']!;
  String get dominantColor =>
      _localizedValues[locale.languageCode]!['dominantColor']!;
  String get extractedColors =>
      _localizedValues[locale.languageCode]!['extractedColors']!;
  String get suggestedPalette =>
      _localizedValues[locale.languageCode]!['suggestedPalette']!;
  String get primary => _localizedValues[locale.languageCode]!['primary']!;
  String get secondary => _localizedValues[locale.languageCode]!['secondary']!;
  String get background =>
      _localizedValues[locale.languageCode]!['background']!;
  String get accent => _localizedValues[locale.languageCode]!['accent']!;
  String get homeGradientGeneratorTitle =>
      _localizedValues[locale.languageCode]!['homeGradientGeneratorTitle']!;
  String get homeGradientGeneratorSubtitle =>
      _localizedValues[locale.languageCode]!['homeGradientGeneratorSubtitle']!;
  String get gradientScreenTitle =>
      _localizedValues[locale.languageCode]!['gradientScreenTitle']!;
  String get gradientColors =>
      _localizedValues[locale.languageCode]!['gradientColors']!;
  String get gradientType =>
      _localizedValues[locale.languageCode]!['gradientType']!;
  String get gradientLinear =>
      _localizedValues[locale.languageCode]!['gradientLinear']!;
  String get gradientRadial =>
      _localizedValues[locale.languageCode]!['gradientRadial']!;
  String get gradientAddColor =>
      _localizedValues[locale.languageCode]!['gradientAddColor']!;
  String get gradientRemoveColor =>
      _localizedValues[locale.languageCode]!['gradientRemoveColor']!;
  String get gradientPreview =>
      _localizedValues[locale.languageCode]!['gradientPreview']!;
  String get gradientAlignment =>
      _localizedValues[locale.languageCode]!['gradientAlignment']!;
  String get gradientSave =>
      _localizedValues[locale.languageCode]!['gradientSave']!;
  String get gradientCopyCode =>
      _localizedValues[locale.languageCode]!['gradientCopyCode']!;
  String get gradientCodeCopied =>
      _localizedValues[locale.languageCode]!['gradientCodeCopied']!;
  String get gradientSaved =>
      _localizedValues[locale.languageCode]!['gradientSaved']!;
  String get alignLinear =>
      _localizedValues[locale.languageCode]!['alignLinear']!;
  String get alignRadial =>
      _localizedValues[locale.languageCode]!['alignRadial']!;
  String get alignLinearLeftRight =>
      _localizedValues[locale.languageCode]!['alignLinearLeftRight']!;
  String get alignLinearTopBottom =>
      _localizedValues[locale.languageCode]!['alignLinearTopBottom']!;
  String get alignLinearTopLeftBottomRight =>
      _localizedValues[locale.languageCode]!['alignLinearTopLeftBottomRight']!;
  String get alignLinearBottomLeftTopRight =>
      _localizedValues[locale.languageCode]!['alignLinearBottomLeftTopRight']!;
}

// Delegate class
class _AppLocalDelegate extends LocalizationsDelegate<AppLocal> {
  const _AppLocalDelegate();
  @override
  bool isSupported(Locale locale) => AppLocal.supportedLocales
      .map((e) => e.languageCode)
      .contains(locale.languageCode);
  @override
  Future<AppLocal> load(Locale locale) async => AppLocal(locale);
  @override
  bool shouldReload(_AppLocalDelegate old) => false;
}
