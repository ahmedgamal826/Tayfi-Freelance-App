import 'package:flutter/material.dart';
import 'package:tayfi/services/category_service.dart';
import 'package:tayfi/widgets/tool_widgets/tool_card_item.dart';
import 'package:tayfi/widgets/tool_widgets/tool_background.dart';
import 'package:tayfi/widgets/tool_widgets/tool_grid.dart';
import 'package:tayfi/widgets/tool_widgets/tool_header.dart';
import 'package:tayfi/widgets/tool_widgets/tool_status_view.dart';

class BagDetailsScreen extends StatelessWidget {
  const BagDetailsScreen({
    super.key,
    required this.categoryId,
    required this.bagTitleArabic,
    required this.bagTitleEnglish,
  });

  final int categoryId;
  final String bagTitleArabic;
  final String bagTitleEnglish;

  static final CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BagDetailsBackground(),
          SafeArea(
            child: FutureBuilder<CategoryDetails>(
              future: _categoryService.fetchCategoryDetails(categoryId),
              builder: (context, snapshot) {
                final details = snapshot.data;
                final resolvedArabic = details?.arabicTitle.isNotEmpty == true
                    ? details!.arabicTitle
                    : bagTitleArabic;

                return Column(
                  children: [
                    BagDetailsHeader(
                      bagTitleArabic: resolvedArabic,
                      onBack: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const ToolStatusView(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return ToolStatusView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.error_outline_rounded,
                                    color: Colors.white,
                                    size: 34,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'تعذر تحميل تفاصيل الفئة',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'يرجى المحاولة مرة أخرى بعد قليل.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.92,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            );
                          }

                          final items =
                              details?.tools ?? const <BagDetailCardItem>[];
                          if (items.isEmpty) {
                            return ToolStatusView(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.10,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.inventory_2_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'لا توجد أدوات متاحة لهذه الفئة۔',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            height: 1.45,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return BagDetailsGrid(items: items);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
