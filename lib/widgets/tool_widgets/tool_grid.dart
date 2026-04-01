import 'package:flutter/material.dart';
import 'package:tayfi/widgets/tool_widgets/tool_card_item.dart';
import 'package:tayfi/widgets/tool_widgets/tool_card.dart';

class BagDetailsGrid extends StatelessWidget {
  const BagDetailsGrid({
    super.key,
    required this.items,
  });

  final List<BagDetailCardItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width >= 900
            ? 4
            : width >= 680
                ? 3
                : 2;
        final spacing = width >= 680 ? 16.0 : 12.0;
        final childAspectRatio = width >= 900
            ? 0.78
            : width >= 680
                ? 0.75
                : 0.72;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: GridView.builder(
            padding: EdgeInsets.fromLTRB(
              width >= 680 ? 24 : 16,
              12,
              width >= 680 ? 24 : 16,
              24,
            ),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              return BagLearningCard(item: items[index]);
            },
          ),
        );
      },
    );
  }
}
