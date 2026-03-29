import 'package:flutter/material.dart';
import 'package:tayfi/views/bag_details_screen.dart';
import 'package:tayfi/widgets/home_widgets/bag_item.dart';
import 'package:tayfi/widgets/home_widgets/home_background.dart';
import 'package:tayfi/widgets/home_widgets/home_bag_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<BagItem> _bagItems = [
    BagItem(
      arabicTitle: 'المهارات الحياتية',
      englishTitle: 'Social Skills',
      imagePath: 'assets/images/purpleBag.png',
    ),
    BagItem(
      arabicTitle: 'التواصل البصري',
      englishTitle: 'Visual Communication',
      imagePath: 'assets/images/greenImage.png',
    ),
    BagItem(
      arabicTitle: 'التفاعل الاجتماعي',
      englishTitle: 'Social Interaction',
      imagePath: 'assets/images/orangeBag.png',
    ),
    BagItem(
      arabicTitle: 'تعديل السلوك',
      englishTitle: 'Behavior Development',
      imagePath: 'assets/images/blueBag.png',
    ),
    BagItem(
      arabicTitle: 'التواصل السمعي',
      englishTitle: 'Auditory Communication',
      imagePath: 'assets/images/yellowBag.png',
    ),
    BagItem(
      arabicTitle: 'الأمان',
      englishTitle: 'Safety',
      imagePath: 'assets/images/blackBag.png',
    ),
    BagItem(
      arabicTitle: 'تنمية المهارات المعرفية',
      englishTitle: 'Cognitive Skills Development',
      imagePath: 'assets/images/pinkBag.png',
    ),
    BagItem(
      arabicTitle: 'التعلم الأكاديمي',
      englishTitle: 'Academic Learning',
      imagePath: 'assets/images/redBag.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const HomeBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 178),
                Expanded(
                  child: HomeBagGrid(
                    items: _bagItems,
                    onBagTap: (item) {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => BagDetailsScreen(
                            bagTitleArabic: item.arabicTitle,
                            bagTitleEnglish: item.englishTitle,
                          ),
                        ),
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
