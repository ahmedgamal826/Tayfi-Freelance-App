import 'package:flutter/material.dart';
import 'package:tayfi/services/category_service.dart';
import 'package:tayfi/services/sound_service.dart';
import 'package:tayfi/views/tools_screen.dart';
import 'package:tayfi/widgets/home_widgets/tool_item.dart';
import 'package:tayfi/widgets/home_widgets/home_background.dart';
import 'package:tayfi/widgets/home_widgets/home_bag_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLandscape = constraints.maxWidth > constraints.maxHeight;
          final topSpacing = isLandscape ? 78.0 : 178.0;

          return Stack(
            fit: StackFit.expand,
            children: [
              const HomeBackground(),
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: topSpacing),
                    Expanded(
                      child: FutureBuilder<List<BagItem>>(
                        future: _categoryService.fetchCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const _HomeStatusView(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return _HomeStatusView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.cloud_off_rounded,
                                    color: Colors.white,
                                    size: 34,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'تعذر تحميل الفئات الآن',
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
                                    'Please try again in a moment.',
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

                          final items = snapshot.data ?? const <BagItem>[];
                          if (items.isEmpty) {
                            return _HomeStatusView(
                              child: Text(
                                'No categories available right now.',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            );
                          }

                          return HomeBagGrid(
                            items: items,
                            onBagTap: (item) async {
                              await SoundService.playCategoryClick();
                              if (!context.mounted) return;
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => BagDetailsScreen(
                                    categoryId: item.id,
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
          );
        },
      ),
    );
  }
}

class _HomeStatusView extends StatelessWidget {
  const _HomeStatusView({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.26),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}
