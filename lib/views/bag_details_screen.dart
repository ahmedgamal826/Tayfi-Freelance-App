import 'package:flutter/material.dart';

class BagDetailsScreen extends StatelessWidget {
  const BagDetailsScreen({
    super.key,
    required this.bagTitleArabic,
    required this.bagTitleEnglish,
  });

  final String bagTitleArabic;
  final String bagTitleEnglish;

  static const List<_CardItem> _cardItems = [
    _CardItem(
      arabicTitle: 'سبورة وقلم ماركر',
      englishTitle: 'Whiteboard & Marker',
    ),
    _CardItem(
      arabicTitle: 'حروف وأرقام مغناطيسية',
      englishTitle: 'Magnetic Letters & Numbers',
    ),
    _CardItem(
      arabicTitle: 'كتب القراءة البسيطة',
      englishTitle: 'Simple Reading Books',
    ),
    _CardItem(
      arabicTitle: 'صينية الرمل للكتابة',
      englishTitle: 'Sand Writing Tray',
    ),
    _CardItem(
      arabicTitle: 'مكعبات الحروف',
      englishTitle: 'Letter Cubes',
    ),
    _CardItem(
      arabicTitle: 'أقلام التلوين السميكة',
      englishTitle: 'Easy Grip Crayons',
    ),
    _CardItem(
      arabicTitle: 'المقصات الآمنة',
      englishTitle: 'Safety Scissors',
    ),
    _CardItem(
      arabicTitle: 'لوحة التقويم',
      englishTitle: 'Calendar Board',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/homeBackgroundImage.jpg',
            fit: BoxFit.fill,
          ),
          Container(
            color: const Color(0x993E2716),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                bagTitleArabic,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ),
                            Text(
                              bagTitleEnglish,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.92),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: _cardItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.76,
                    ),
                    itemBuilder: (context, index) {
                      return _LearningCard(item: _cardItems[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardItem {
  const _CardItem({
    required this.arabicTitle,
    required this.englishTitle,
  });

  final String arabicTitle;
  final String englishTitle;
}

class _LearningCard extends StatelessWidget {
  const _LearningCard({required this.item});

  final _CardItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.05),
                    Colors.black.withValues(alpha: 0.45),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xA34A2E1A),
                borderRadius: BorderRadius.circular(14),
              ),
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
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.englishTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.94),
                          fontWeight: FontWeight.w600,
                          height: 1.15,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
