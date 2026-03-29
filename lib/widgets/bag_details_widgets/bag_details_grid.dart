import 'package:flutter/material.dart';
import 'package:tayfi/widgets/bag_details_widgets/bag_detail_card_item.dart';
import 'package:tayfi/widgets/bag_details_widgets/bag_learning_card.dart';

class BagDetailsGrid extends StatelessWidget {
  const BagDetailsGrid({
    super.key,
    required this.items,
  });

  final List<BagDetailCardItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 14,
        childAspectRatio: 0.76,
      ),
      itemBuilder: (context, index) {
        return BagLearningCard(item: items[index]);
      },
    );
  }
}
