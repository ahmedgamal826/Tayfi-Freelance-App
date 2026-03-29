import 'package:flutter/material.dart';
import 'package:tayfi/widgets/home_widgets/bag_item.dart';

class HomeBagCard extends StatelessWidget {
  const HomeBagCard({
    super.key,
    required this.imagePath,
    required this.item,
    required this.onTap,
  });

  final String imagePath;
  final BagItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
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
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 22,
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
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.4
                                    ..color = const Color(0xCC215B18),
                                  height: 1.05,
                                ),
                          ),
                          Text(
                            item.arabicTitle,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  height: 1.05,
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
                    const SizedBox(height: 1),
                    Text(
                      item.englishTitle,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 8.2,
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
  }
}
