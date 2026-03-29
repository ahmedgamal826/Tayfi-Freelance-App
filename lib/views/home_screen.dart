import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<_BagItem> _bagItems = [
    _BagItem(
      arabicTitle: 'المهارات الحياتية',
      englishTitle: 'Social Skills',
    ),
    _BagItem(
      arabicTitle: 'التواصل البصري',
      englishTitle: 'Visual Communication',
    ),
    _BagItem(
      arabicTitle: 'التفاعل الاجتماعي',
      englishTitle: 'Social Interaction',
    ),
    _BagItem(
      arabicTitle: 'تعديل السلوك',
      englishTitle: 'Behavior Development',
    ),
    _BagItem(
      arabicTitle: 'التواصل السمعي',
      englishTitle: 'Auditory Communication',
    ),
    _BagItem(
      arabicTitle: 'الأمان',
      englishTitle: 'Safety',
    ),
    _BagItem(
      arabicTitle: 'تنمية المهارات المعرفية',
      englishTitle: 'Cognitive Skills Development',
    ),
    _BagItem(
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
                      return _BagCard(
                        imagePath: 'assets/images/bagImage.png',
                        item: _bagItems[index],
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

class _BagItem {
  const _BagItem({
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
  });

  final String imagePath;
  final _BagItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
