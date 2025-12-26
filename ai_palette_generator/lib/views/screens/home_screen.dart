import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/services/theme_service.dart'; 
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
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
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.appTitle,
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Create beautiful color palettes',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final int crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
                  
                  final double childAspectRatio = _getChildAspectRatio(constraints.maxWidth);

                  return GridView.count(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: childAspectRatio,
                    children: options.map((option) {
                      return OptionCard(
                        title: option['title'] as String,
                        subtitle: option['subtitle'] as String,
                        icon: option['icon'] as IconData,
                        color: option['color'] as Color,
                        onTap: option['onTap'] as VoidCallback,
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

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth >= 1200) {
      return 4; // Desktop
    } else if (screenWidth >= 900) {
      return 3; // Large tablet
    } else if (screenWidth >= 600) {
      return 2; // Small tablet / landscape 
    } else {
      return 2; // Mobile
    }
  }

  double _getChildAspectRatio(double screenWidth) {
    if (screenWidth >= 1200) {
      return 1.3;
    } else if (screenWidth >= 600) {
      return 1.1;
    } else {
      return 0.95;
    }
  }
}
