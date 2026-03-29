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
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 24,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return HomeBagCard(
          imagePath: 'assets/images/bagImage.png',
          item: item,
          onTap: () => onBagTap(item),
        );
      },
    );
  }
}
