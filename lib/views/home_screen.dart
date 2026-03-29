import 'package:flutter/material.dart';
import 'package:tayfi/views/bag_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<BagItem> _bagItems = [
    BagItem(
      arabicTitle: 'المهارات الحياتية',
      englishTitle: 'Social Skills',
    ),
    BagItem(
      arabicTitle: 'التواصل البصري',
      englishTitle: 'Visual Communication',
    ),
    BagItem(
      arabicTitle: 'التفاعل الاجتماعي',
      englishTitle: 'Social Interaction',
    ),
    BagItem(
      arabicTitle: 'تعديل السلوك',
      englishTitle: 'Behavior Development',
    ),
    BagItem(
      arabicTitle: 'التواصل السمعي',
      englishTitle: 'Auditory Communication',
    ),
    BagItem(
      arabicTitle: 'الأمان',
      englishTitle: 'Safety',
    ),
    BagItem(
      arabicTitle: 'تنمية المهارات المعرفية',
      englishTitle: 'Cognitive Skills Development',
    ),
    BagItem(
      arabicTitle: 'التعلم الأكاديمي',
      englishTitle: 'Academic Learning',
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
            alignment: Alignment.center,
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 190),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemCount: _bagItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      final item = _bagItems[index];
                      return _BagCard(
                        imagePath: 'assets/images/bagImage.png',
                        item: item,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BagDetailsScreen(
                                bagTitleArabic: item.arabicTitle,
                                bagTitleEnglish: item.englishTitle,
                              ),
                            ),
                          );
                        },
                      );
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

class BagItem {
  const BagItem({
    required this.arabicTitle,
    required this.englishTitle,
  });

  final String arabicTitle;
  final String englishTitle;
}

class _BagCard extends StatelessWidget {
  const _BagCard({
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
