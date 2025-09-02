import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/services/ai_palette_service.dart';
import 'package:ai_palette_generator/views/widgets/color_strip.dart';

final _imageUploadStateProvider =
    StateProvider<({String imageType, String description})>(
      (ref) => (imageType: 'photo', description: ''),
    );

final imagePaletteProvider = StateNotifierProvider.autoDispose
    .family<ImagePaletteNotifier, AsyncValue<ImageAnalysisResult?>, String>((
      ref,
      lang,
    ) {
      return ImagePaletteNotifier(ref: ref, languageCode: lang);
    });

class ImagePaletteNotifier
    extends StateNotifier<AsyncValue<ImageAnalysisResult?>> {
  final String languageCode;
  final Ref ref;

  ImagePaletteNotifier({required this.ref, required this.languageCode})
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
        final uploadState = ref.read(_imageUploadStateProvider);
        final ImageAnalysisResult result = await _aiService.getPaletteFromImage(
          imageBytes: imageBytes,
          languageCode: languageCode,
          imageType: uploadState.imageType,
          contextDescription: uploadState.description,
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
        actions: [
          paletteState.maybeWhen(
            data: (d) => d != null
                ? IconButton(
                    icon: const Icon(Icons.refresh),
                    tooltip: l10n.startOver,
                    onPressed: () {
                      ref.invalidate(imagePaletteProvider(currentLocale));
                      ref.read(_imageUploadStateProvider.notifier).state = (
                        imageType: 'photo',
                        description: '',
                      );
                    },
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
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
                  textAlign: TextAlign.center,
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
    final uploadState = ref.watch(_imageUploadStateProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.imageTypeTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          RadioListTile<String>(
            title: Text(l10n.imageTypePhoto),
            subtitle: Text(l10n.imageTypePhotoDesc),
            value: 'photo',
            groupValue: uploadState.imageType,
            onChanged: (v) => ref
                .read(_imageUploadStateProvider.notifier)
                .update((s) => (imageType: v!, description: s.description)),
          ),
          RadioListTile<String>(
            title: Text(l10n.imageTypeLogo),
            subtitle: Text(l10n.imageTypeLogoDesc),
            value: 'logo',
            groupValue: uploadState.imageType,
            onChanged: (v) => ref
                .read(_imageUploadStateProvider.notifier)
                .update((s) => (imageType: v!, description: s.description)),
          ),
          if (uploadState.imageType == 'logo') ...[
            const SizedBox(height: 16),
            TextField(
              onChanged: (v) => ref
                  .read(_imageUploadStateProvider.notifier)
                  .update((s) => (imageType: s.imageType, description: v)),
              decoration: InputDecoration(
                labelText: l10n.logoContextLabel,
                hintText: l10n.logoContextHint,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
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
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (result.logoCritique != null) ...[
          Text(l10n.logoCritiqueTitle, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
            ),
            child: Text(
              result.logoCritique!,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
            ),
          ),
          const SizedBox(height: 32),
        ],

        Text(l10n.colorAnalysisTitle, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true, 
          physics:
              const NeverScrollableScrollPhysics(), 
          itemCount: result.palette.length,
          separatorBuilder: (context, index) => const Divider(height: 32),
          itemBuilder: (context, index) {
            final analysis = result.palette[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${analysis.name} (${analysis.hex})',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  analysis.usageSuggestion,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: analysis.shades.map((color) {
                      return Expanded(
                        child: SizedBox(
                          height: 60,
                          child: ColorStrip(color: color),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
