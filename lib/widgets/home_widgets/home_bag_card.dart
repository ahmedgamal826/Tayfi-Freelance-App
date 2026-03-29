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
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 16,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 18,
                right: 18,
                bottom: 34,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        item.arabicTitle,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.05,
                              shadows: const [
                                Shadow(
                                  color: Color(0xCC215B18),
                                  blurRadius: 5,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.englishTitle,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 10,
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
