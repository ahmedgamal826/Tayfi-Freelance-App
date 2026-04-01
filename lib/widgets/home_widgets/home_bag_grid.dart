import 'package:flutter/material.dart';
import 'package:tayfi/widgets/home_widgets/tool_item.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final crossAxisCount = isLandscape ? 3 : 2;
        final horizontalPadding = isLandscape ? 14.0 : 18.0;
        final topPadding = isLandscape ? 4.0 : 4.0;
        final bottomPadding = isLandscape ? 10.0 : 14.0;
        final crossSpacing = isLandscape ? 12.0 : 14.0;
        final mainSpacing = isLandscape ? 10.0 : 12.0;

        final totalHorizontalSpacing =
            (horizontalPadding * 2) + ((crossAxisCount - 1) * crossSpacing);
        final tileWidth =
            (constraints.maxWidth - totalHorizontalSpacing) / crossAxisCount;

        final rows = (items.length / crossAxisCount).ceil().clamp(1, 1000);
        final totalVerticalSpacing =
            topPadding + bottomPadding + ((rows - 1) * mainSpacing);
        final tileHeight =
            (constraints.maxHeight - totalVerticalSpacing) / rows;

        final childAspectRatio = tileWidth / tileHeight.clamp(1, double.infinity);

        return GridView.builder(
          physics: isLandscape
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            topPadding,
            horizontalPadding,
            bottomPadding,
          ),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossSpacing,
            mainAxisSpacing: mainSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return HomeBagCard(
              imagePath: item.imagePath,
              item: item,
              onTap: () => onBagTap(item),
              compact: isLandscape,
            );
          },
        );
      },
    );
  }
}
