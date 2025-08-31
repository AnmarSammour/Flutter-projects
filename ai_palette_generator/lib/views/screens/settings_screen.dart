import 'package:ai_palette_generator/controllers/language_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocal.of(context);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsScreenTitle),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text(l10n.languageLabel),
              trailing: DropdownButton<Locale>(
                value: currentLocale,
                items: [
                  DropdownMenuItem(
                    value: const Locale('ar'),
                    child: Text(l10n.arabic),
                  ),
                  DropdownMenuItem(
                    value: const Locale('en'),
                    child: Text(l10n.english),
                  ),
                ],
                onChanged: (newLocale) {
                  if (newLocale != null) {
                    ref.read(localeProvider.notifier).state = newLocale;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
