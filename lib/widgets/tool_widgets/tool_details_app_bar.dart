import 'package:flutter/material.dart';

class ToolDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ToolDetailsAppBar({
    super.key,
    required this.titleArabic,
    required this.titleEnglish,
    required this.onBack,
  });

  final String titleArabic;
  final String titleEnglish;
  final VoidCallback onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withValues(alpha: 0.72),
      foregroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 12,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: onBack,
              icon: Transform.flip(
                flipX: true,
                child: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    titleArabic,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
