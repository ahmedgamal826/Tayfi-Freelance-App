import 'package:flutter/material.dart';
import 'package:tayfi/widgets/bag_details_widgets/bag_detail_card_item.dart';
import 'package:tayfi/widgets/bag_details_widgets/bag_details_background.dart';
import 'package:tayfi/widgets/bag_details_widgets/bag_details_grid.dart';
import 'package:tayfi/widgets/bag_details_widgets/bag_details_header.dart';

class BagDetailsScreen extends StatelessWidget {
  const BagDetailsScreen({
    super.key,
    required this.bagTitleArabic,
    required this.bagTitleEnglish,
  });

  final String bagTitleArabic;
  final String bagTitleEnglish;

  static const List<BagDetailCardItem> _cardItems = [
    BagDetailCardItem(
      arabicTitle: 'سبورة وقلم ماركر',
      englishTitle: 'Whiteboard & Marker',
    ),
    BagDetailCardItem(
      arabicTitle: 'حروف وأرقام مغناطيسية',
      englishTitle: 'Magnetic Letters & Numbers',
    ),
    BagDetailCardItem(
      arabicTitle: 'كتب القراءة البسيطة',
      englishTitle: 'Simple Reading Books',
    ),
    BagDetailCardItem(
      arabicTitle: 'صينية الرمل للكتابة',
      englishTitle: 'Sand Writing Tray',
    ),
    BagDetailCardItem(
      arabicTitle: 'مكعبات الحروف',
      englishTitle: 'Letter Cubes',
    ),
    BagDetailCardItem(
      arabicTitle: 'أقلام التلوين السميكة',
      englishTitle: 'Easy Grip Crayons',
    ),
    BagDetailCardItem(
      arabicTitle: 'المقصات الآمنة',
      englishTitle: 'Safety Scissors',
    ),
    BagDetailCardItem(
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
          const BagDetailsBackground(),
          SafeArea(
            child: Column(
              children: [
                BagDetailsHeader(
                  bagTitleArabic: bagTitleArabic,
                  bagTitleEnglish: bagTitleEnglish,
                  onBack: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: BagDetailsGrid(items: _cardItems),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
