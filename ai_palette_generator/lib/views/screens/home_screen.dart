import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/views/screens/generation/ai_generate_screen.dart';
import 'package:ai_palette_generator/views/screens/generation/base_color_generate_screen.dart';
import 'package:ai_palette_generator/views/screens/generation/industry_generate_screen.dart';
import 'package:ai_palette_generator/views/screens/generation/random_generate_screen.dart';
import 'package:ai_palette_generator/views/screens/gradient_generator_screen.dart';
import 'package:ai_palette_generator/views/screens/upload_screen.dart';
import 'package:ai_palette_generator/views/widgets/option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocal.of(context);
    final theme = Theme.of(context);
    final List<Map<String, dynamic>> options = [
      {
        'title': l10n.homeAiGeneratorTitle,
        'subtitle': l10n.homeAiGeneratorSubtitle,
        'icon': Icons.auto_awesome,
        'color': Colors.purpleAccent,
        'onTap': () => _navigateTo(context, const AiGenerateScreen()),
      },
      {
        'title': l10n.homeRandomGeneratorTitle,
        'subtitle': l10n.homeRandomGeneratorSubtitle,
        'icon': Icons.shuffle,
        'color': Colors.orangeAccent,
        'onTap': () => _navigateTo(context, const RandomGenerateScreen()),
      },
      {
        'title': l10n.homeBaseColorGeneratorTitle,
        'subtitle': l10n.homeBaseColorGeneratorSubtitle,
        'icon': Icons.colorize,
        'color': Colors.blueAccent,
        'onTap': () => _navigateTo(context, const BaseColorGenerateScreen()),
      },
      {
        'title': l10n.homeIndustryGeneratorTitle,
        'subtitle': l10n.homeIndustryGeneratorSubtitle,
        'icon': Icons.business_center_outlined,
        'color': Colors.teal,
        'onTap': () => _navigateTo(context, const IndustryGenerateScreen()),
      },
      {
        'title': l10n.homeUploadImageTitle,
        'subtitle': l10n.homeUploadImageSubtitle,
        'icon': Icons.image_search,
        'color': Colors.greenAccent,
        'onTap': () => _navigateTo(context, const UploadScreen()),
      },
      {
        'title': l10n.homeGradientGeneratorTitle,
        'subtitle': l10n.homeGradientGeneratorSubtitle,
        'icon': Icons.gradient_outlined,
        'color': Colors.pinkAccent,
        'onTap': () => _navigateTo(context, const GradientGeneratorScreen()),
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
              child: Text(
                l10n.appTitle,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double screenWidth = constraints.maxWidth;
                  final int crossAxisCount;
                  if (screenWidth >= 1200) {
                    crossAxisCount = 4;
                  } else if (screenWidth >= 600) {
                    crossAxisCount = 3; 
                  } else {
                    crossAxisCount = 2; 
                  }

                  final double childAspectRatio = (screenWidth < 600) ? 1.0 : 1.2;
                  return GridView.count(
                    padding: const EdgeInsets.all(16.0),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: childAspectRatio,
                    children: options.map((option) {
                      return OptionCard(
                        title: option['title'],
                        subtitle: option['subtitle'],
                        icon: option['icon'],
                        color: option['color'],
                        onTap: option['onTap'],
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
