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
    'navHome': 'الرئيسية',
    'navGenerate': 'إنشاء',
    'navFavorites': 'المفضلة',
    'navSettings': 'الإعدادات',
    'homeGeneratePaletteTitle': 'إنشاء لوحة',
    'homeGeneratePaletteSubtitle': 'من الصفر، لون، أو وصف',
    'homeFavoritesTitle': 'المفضلة',
    'homeFavoritesSubtitle': 'لوحاتك المحفوظة',
    'generateScreenTitle': 'إنشاء لوحة ألوان',
    'colorCountLabel': 'عدد الألوان',
    'copiedToClipboard': 'تم نسخ الكود: ',
    'errorFailedToLoad': 'حدث خطأ في جلب اللوحة',
    'settingsScreenTitle': 'الإعدادات',
    'languageLabel': 'اللغة',
    'arabic': 'العربية',
    'english': 'الإنجليزية',
    'baseColorLabel': 'اللون الأساسي',
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
    'imageTypeTitle': 'ما هو نوع الصورة؟',
    'imageTypePhoto': 'صورة فوتوغرافية',
    'imageTypePhotoDesc': 'لتحليل الألوان السائدة في مشهد أو كائن.',
    'imageTypeLogo': 'شعار (Logo)',
    'imageTypeLogoDesc': 'لتحليل دقيق لألوان الهوية البصرية.',
    'logoContextLabel': 'صف استخدام الشعار (اختياري)',
    'logoContextHint': 'مثال: تطبيق بنكي، متجر إلكتروني...',
    'startOver': 'البدء من جديد',
    'logoCritiqueTitle': 'تقييم الشعار',
    'colorAnalysisTitle': 'تحليل الألوان',
    'appTitle': 'مولد لوحات الألوان',
    'homeAiGeneratorTitle': 'إنشاء بوصف (AI)',
    'homeAiGeneratorSubtitle': 'صف تصميمك والذكاء الاصطناعي يُنشئ',
    'homeRandomGeneratorTitle': 'إنشاء عشوائي',
    'homeRandomGeneratorSubtitle': 'لوحات ألوان سريعة وغير متوقعة',
    'homeBaseColorGeneratorTitle': 'إنشاء من لون أساسي',
    'homeBaseColorGeneratorSubtitle': 'اختر لونًا وابنِ لوحة حوله',
    'homeIndustryGeneratorTitle': 'ألوان حسب المجال',
    'homeIndustryGeneratorSubtitle': 'لوحات جاهزة لمجالات مختلفة',
    'homeUploadImageTitle': 'تحليل صورة',
    'homeUploadImageSubtitle': 'استخراج وتحليل الألوان',
    'refreshButton': 'تحديث',
    'generateButton': 'إنشاء',
    'pickColorButton': 'اختر لون أساسي',
    'aiDescriptionLabel': 'صف تصميمك أو فكرتك',
    'aiDescriptionHint': 'مثال: تطبيق تأمل هادئ بألوان الطبيعة...',
    'aiScreenInitialText': 'اكتب وصفًا لتصميمك لتبدأ',
    'designContextLabel': 'ما هو سياق التصميم؟',
    'contextApp': 'واجهة تطبيق',
    'contextLogo': 'تصميم شعار',
    'contextPainting': 'لوحة فنية',
    'contextOther': 'أخرى',
  };

  // --- ENGLISH ---
  static final Map<String, String> _en = {
    'navHome': 'Home',
    'navGenerate': 'Generate',
    'navFavorites': 'Favorites',
    'navSettings': 'Settings',
    'homeGeneratePaletteTitle': 'Generate Palette',
    'homeGeneratePaletteSubtitle': 'From scratch, color, or text',
    'homeFavoritesTitle': 'Favorites',
    'homeFavoritesSubtitle': 'Your saved palettes',
    'generateScreenTitle': 'Generate Color Palette',
    'colorCountLabel': 'Number of Colors',
    'copiedToClipboard': 'Copied to clipboard: ',
    'errorFailedToLoad': 'Failed to load palette',
    'settingsScreenTitle': 'Settings',
    'languageLabel': 'Language',
    'arabic': 'Arabic',
    'english': 'English',
    'baseColorLabel': 'Base Color',
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
    'generateFromDescription': 'Generate from Description',
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
    'imageTypeTitle': 'What is the image type?',
    'imageTypePhoto': 'Photograph',
    'imageTypePhotoDesc': 'To analyze dominant colors in a scene or object.',
    'imageTypeLogo': 'Logo',
    'imageTypeLogoDesc': 'For precise analysis of brand identity colors.',
    'logoContextLabel': 'Describe the logo\'s use (optional)',
    'logoContextHint': 'e.g., banking app, e-commerce store...',
    'startOver': 'Start Over',
    'logoCritiqueTitle': 'Logo Critique',
    'colorAnalysisTitle': 'Color Analysis',
    'appTitle': 'Palette Generator',
    'homeAiGeneratorTitle': 'Generate with AI',
    'homeAiGeneratorSubtitle': 'Describe your design for an AI palette',
    'homeRandomGeneratorTitle': 'Random Generator',
    'homeRandomGeneratorSubtitle': 'Quick and unexpected color palettes',
    'homeBaseColorGeneratorTitle': 'Generate from Base Color',
    'homeBaseColorGeneratorSubtitle':
        'Pick a color and build a palette around it',
    'homeIndustryGeneratorTitle': 'Palettes by Industry',
    'homeIndustryGeneratorSubtitle': 'Ready-made palettes for different fields',
    'homeUploadImageTitle': 'Analyze Image',
    'homeUploadImageSubtitle': 'Extract & analyze colors',
    'refreshButton': 'Refresh',
    'generateButton': 'Generate',
    'pickColorButton': 'Pick a Base Color',
    'aiDescriptionLabel': 'Describe your design or idea',
    'aiDescriptionHint': 'e.g., a calm meditation app with nature colors...',
    'aiScreenInitialText': 'Write a description of your design to start',
    'uploadScreenTitle': 'Analyze Colors from Image',
    'designContextLabel': 'What is the design context?',
    'contextApp': 'App UI',
    'contextLogo': 'Logo Design',
    'contextPainting': 'Artistic Painting',
    'contextOther': 'Other',
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
  String get imageTypeTitle =>
      _localizedValues[locale.languageCode]!['imageTypeTitle']!;
  String get imageTypePhoto =>
      _localizedValues[locale.languageCode]!['imageTypePhoto']!;
  String get imageTypePhotoDesc =>
      _localizedValues[locale.languageCode]!['imageTypePhotoDesc']!;
  String get imageTypeLogo =>
      _localizedValues[locale.languageCode]!['imageTypeLogo']!;
  String get imageTypeLogoDesc =>
      _localizedValues[locale.languageCode]!['imageTypeLogoDesc']!;
  String get logoContextLabel =>
      _localizedValues[locale.languageCode]!['logoContextLabel']!;
  String get logoContextHint =>
      _localizedValues[locale.languageCode]!['logoContextHint']!;
  String get startOver => _localizedValues[locale.languageCode]!['startOver']!;
  String get logoCritiqueTitle =>
      _localizedValues[locale.languageCode]!['logoCritiqueTitle']!;
  String get colorAnalysisTitle =>
      _localizedValues[locale.languageCode]!['colorAnalysisTitle']!;
  String get homeAiGeneratorTitle =>
      _localizedValues[locale.languageCode]!['homeAiGeneratorTitle']!;
  String get homeAiGeneratorSubtitle =>
      _localizedValues[locale.languageCode]!['homeAiGeneratorSubtitle']!;
  String get homeRandomGeneratorTitle =>
      _localizedValues[locale.languageCode]!['homeRandomGeneratorTitle']!;
  String get homeRandomGeneratorSubtitle =>
      _localizedValues[locale.languageCode]!['homeRandomGeneratorSubtitle']!;
  String get homeBaseColorGeneratorTitle =>
      _localizedValues[locale.languageCode]!['homeBaseColorGeneratorTitle']!;
  String get homeBaseColorGeneratorSubtitle =>
      _localizedValues[locale.languageCode]!['homeBaseColorGeneratorSubtitle']!;
  String get homeIndustryGeneratorTitle =>
      _localizedValues[locale.languageCode]!['homeIndustryGeneratorTitle']!;
  String get homeIndustryGeneratorSubtitle =>
      _localizedValues[locale.languageCode]!['homeIndustryGeneratorSubtitle']!;
  String get generateButton =>
      _localizedValues[locale.languageCode]!['generateButton']!;
  String get aiScreenInitialText =>
      _localizedValues[locale.languageCode]!['aiScreenInitialText']!;
  String get designContextLabel =>
      _localizedValues[locale.languageCode]!['designContextLabel']!;
  String get contextApp =>
      _localizedValues[locale.languageCode]!['contextApp']!;
  String get contextLogo =>
      _localizedValues[locale.languageCode]!['contextLogo']!;
  String get contextPainting =>
      _localizedValues[locale.languageCode]!['contextPainting']!;
  String get contextOther =>
      _localizedValues[locale.languageCode]!['contextOther']!;
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
