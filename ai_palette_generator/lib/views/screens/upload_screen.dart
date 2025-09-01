import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/services/ai_palette_service.dart';
import 'package:ai_palette_generator/views/widgets/color_strip.dart';

final imagePaletteProvider = StateNotifierProvider.autoDispose
    .family<ImagePaletteNotifier, AsyncValue<ImageAnalysisResult?>, String>((
      ref,
      languageCode,
    ) {
      return ImagePaletteNotifier(languageCode: languageCode);
    });

class ImagePaletteNotifier
    extends StateNotifier<AsyncValue<ImageAnalysisResult?>> {
  final String languageCode;

  ImagePaletteNotifier({required this.languageCode})
    : super(const AsyncValue.data(null));

  final ImagePicker _picker = ImagePicker();
  final AiPaletteService _aiService = AiPaletteService();

  Future<void> pickAndAnalyzeImage(ImageSource source) async {
    state = const AsyncValue.loading();
    try {
      final XFile? imageFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 1024,
      );
      if (imageFile != null) {
        final Uint8List imageBytes = await imageFile.readAsBytes();
        final ImageAnalysisResult result = await _aiService.getPaletteFromImage(
          imageBytes,
          languageCode: languageCode,
        );
        state = AsyncValue.data(result);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

class UploadScreen extends ConsumerWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocal.of(context);
    final currentLocale = Localizations.localeOf(context).languageCode;
    final paletteState = ref.watch(imagePaletteProvider(currentLocale));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.uploadScreenTitle),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: paletteState.when(
          data: (result) {
            if (result == null) {
              return _buildInitialUI(context, ref, currentLocale);
            }
            return _buildResultUI(context, result);
          },
          loading: () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(l10n.uploadAnalyzing),
            ],
          ),
          error: (err, stack) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 16),
                Text(
                  l10n.uploadError,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(err.toString(), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInitialUI(
    BuildContext context,
    WidgetRef ref,
    String languageCode,
  ) {
    final l10n = AppLocal.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.cloud_upload_outlined,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(height: 24),
          Text(
            l10n.uploadInstructions,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          FilledButton.icon(
            icon: const Icon(Icons.photo_library_outlined),
            label: Text(l10n.uploadSelectImage),
            onPressed: () => ref
                .read(imagePaletteProvider(languageCode).notifier)
                .pickAndAnalyzeImage(ImageSource.gallery),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            icon: const Icon(Icons.camera_alt_outlined),
            label: Text(l10n.uploadTakePhoto),
            onPressed: () => ref
                .read(imagePaletteProvider(languageCode).notifier)
                .pickAndAnalyzeImage(ImageSource.camera),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultUI(BuildContext context, ImageAnalysisResult result) {
    final l10n = AppLocal.of(context);
    final colors = result.palette;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          l10n.extractedColors,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var color in colors)
                SizedBox(height: 60, child: ColorStrip(color: color)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.suggestedPalette,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            result.analysis,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(height: 1.5, color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
