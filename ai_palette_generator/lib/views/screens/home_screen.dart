import 'package:ai_palette_generator/controllers/page_index_provider.dart';
import 'package:ai_palette_generator/views/screens/gradient_generator_screen.dart';
import 'package:ai_palette_generator/views/screens/upload_screen.dart';
import 'package:ai_palette_generator/views/widgets/option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_palette_generator/localization/app_local.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocal.of(context);
    final theme = Theme.of(context);

    // --- قائمة البطاقات ---
    // تعريف البيانات في قائمة يجعل الكود أنظف وأسهل للتعديل
    final List<Map<String, dynamic>> options = [
      {
        'title': l10n.homeGeneratePaletteTitle,
        'subtitle': l10n.homeGeneratePaletteSubtitle,
        'icon': Icons.palette_outlined,
        'color': Colors.blueAccent,
        'onTap': () => ref.read(pageIndexProvider.notifier).state = 1,
      },
      {
        'title': l10n.homeUploadImageTitle,
        'subtitle': l10n.homeUploadImageSubtitle,
        'icon': Icons.image_outlined,
        'color': Colors.greenAccent,
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadScreen())),
      },
      {
        'title': l10n.homeGradientGeneratorTitle,
        'subtitle': l10n.homeGradientGeneratorSubtitle,
        'icon': Icons.gradient_outlined,
        'color': Colors.purpleAccent,
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GradientGeneratorScreen())),
      },
      {
        'title': l10n.homeFavoritesTitle,
        'subtitle': l10n.homeFavoritesSubtitle,
        'icon': Icons.favorite_border,
        'color': Colors.redAccent,
        'onTap': () => ref.read(pageIndexProvider.notifier).state = 2,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- قسم العنوان ---
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  l10n.appTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              // --- التصحيح الجذري هنا ---
              // استخدام Expanded مع GridView.builder
              Expanded(
                child: GridView.builder(
                  // لا حاجة لـ controller أو shrinkWrap
                  itemCount: options.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // <-- الأهم: عمود واحد فقط، ليتصرف كقائمة
                    mainAxisSpacing: 16, // مسافة بين العناصر
                    childAspectRatio: 3.5, // نسبة العرض إلى الارتفاع للبطاقة
                  ),
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return OptionCard(
                      title: option['title'],
                      subtitle: option['subtitle'],
                      icon: option['icon'],
                      color: option['color'],
                      onTap: option['onTap'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
