import 'package:flutter/material.dart';
import 'package:tayfi/services/sound_service.dart';
import 'package:tayfi/views/tool_details_screen.dart';
import 'package:tayfi/widgets/tool_widgets/tool_card_item.dart';

class BagLearningCard extends StatelessWidget {
  const BagLearningCard({super.key, required this.item});

  final BagDetailCardItem item;

  Future<void> _openVideo(BuildContext context) async {
    final rawUrl = item.videoUrl.trim();
    if (rawUrl.isEmpty) {
      _showMessage(context, 'لا يوجد رابط متاح لهذه الأداة');
      return;
    }

    final uri = Uri.tryParse(rawUrl);
    if (uri == null) {
      _showMessage(context, 'الرابط غير صالح');
      return;
    }

    if (!context.mounted) return;

    await SoundService.playCategoryClick();
    if (!context.mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => VideoWebViewScreen(
          titleArabic: item.arabicTitle,
          titleEnglish: item.englishTitle,
          usage: item.usage,
          advantage: item.advantage,
          videoUrl: uri.toString(),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var titleFontSize = constraints.maxWidth * 0.088;
        if (item.arabicTitle.length > 16) titleFontSize -= 0.8;
        if (item.arabicTitle.length > 24) titleFontSize -= 1.2;
        if (item.arabicTitle.length > 32) titleFontSize -= 1.0;

        final titleSidePadding =
            (constraints.maxWidth * 0.08).clamp(10.0, 26.0);
        final titleTop = (constraints.maxHeight * 0.03).clamp(8.0, 18.0);
        final titleHeight = (constraints.maxHeight * 0.20).clamp(48.0, 76.0);
        final imageTop = constraints.maxHeight * 0.22;
        final imageBottom = constraints.maxHeight * 0.08;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _openVideo(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 14,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/cardImage.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: titleTop,
                    left: titleSidePadding,
                    right: titleSidePadding,
                    child: Container(
                      height: titleHeight,
                      alignment: Alignment.center,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth - (titleSidePadding * 2),
                            ),
                            child: Text(
                              item.arabicTitle,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: const Color(0xFF3B2414),
                                    fontWeight: FontWeight.w900,
                                    fontSize: titleFontSize.clamp(14.0, 22.0),
                                    height: 1.2,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: imageTop,
                    left: 12,
                    right: 12,
                    bottom: imageBottom,
                    child: item.imageUrl.isNotEmpty
                        ? Image.network(
                            item.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox.shrink();
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
