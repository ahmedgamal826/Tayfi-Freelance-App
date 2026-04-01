import 'package:flutter/material.dart';
import 'package:tayfi/widgets/home_widgets/tool_item.dart';

class HomeBagCard extends StatelessWidget {
  const HomeBagCard({
    super.key,
    required this.imagePath,
    required this.item,
    required this.onTap,
    this.compact = false,
  });

  final String imagePath;
  final BagItem item;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final borderRadius = compact ? 18.0 : 22.0;
        final horizontalTextPadding = constraints.maxWidth < 130
            ? 10.0
            : (compact ? 12.0 : 16.0);
        final isTightCard =
            constraints.maxWidth < 150 || constraints.maxHeight < 150;
        final textTopOffset = compact
            ? constraints.maxHeight * 0.65
            : constraints.maxHeight * 0.63;

        var arabicFontSize = compact ? 13.2 : 14.8;
        if (item.arabicTitle.length > 18) arabicFontSize -= 0.8;
        if (item.arabicTitle.length > 26) arabicFontSize -= 1.0;
        if (isTightCard) arabicFontSize -= 1.1;

        var englishFontSize = compact ? 7.6 : 8.2;
        if (item.englishTitle.length > 20) englishFontSize -= 0.4;
        if (item.englishTitle.length > 32) englishFontSize -= 0.6;
        if (isTightCard) englishFontSize -= 0.6;

        final strokeWidth = compact || isTightCard ? 1.2 : 1.6;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 12,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Image.asset(imagePath, fit: BoxFit.contain),
                  ),
                  Positioned(
                    left: horizontalTextPadding,
                    right: horizontalTextPadding,
                    top: textTopOffset,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                item.arabicTitle,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      fontSize: arabicFontSize.clamp(
                                        11.0,
                                        14.8,
                                      ),
                                      fontWeight: FontWeight.w900,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = strokeWidth
                                        ..color = const Color(0xCC215B18),
                                      height: 1.0,
                                    ),
                              ),
                              Text(
                                item.arabicTitle,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      fontSize: arabicFontSize.clamp(
                                        11.0,
                                        14.8,
                                      ),
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      height: 1.0,
                                      shadows: const [
                                        Shadow(
                                          color: Color(0xCC215B18),
                                          blurRadius: 6,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.englishTitle,
                          textAlign: TextAlign.center,
                          maxLines: isTightCard ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: englishFontSize.clamp(6.8, 8.2),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.0,
                                shadows: const [
                                  Shadow(
                                    color: Color(0xCC215B18),
                                    blurRadius: 5,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                        ),
                      ],
                    ),
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
