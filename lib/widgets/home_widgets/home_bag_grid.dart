import 'package:flutter/material.dart';
import 'package:tayfi/widgets/home_widgets/bag_item.dart';
import 'package:tayfi/widgets/home_widgets/home_bag_card.dart';

class HomeBagGrid extends StatelessWidget {
  const HomeBagGrid({
    super.key,
    required this.items,
    required this.onBagTap,
  });

  final List<BagItem> items;
  final ValueChanged<BagItem> onBagTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(18, 4, 18, 14),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 12,
        childAspectRatio: 1.28,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return HomeBagCard(
          imagePath: item.imagePath,
          item: item,
          onTap: () => onBagTap(item),
        );
      },
    );
  }
}
