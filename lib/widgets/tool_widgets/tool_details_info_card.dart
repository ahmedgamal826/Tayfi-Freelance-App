import 'package:flutter/material.dart';

class ToolDetailsInfoCard extends StatelessWidget {
  const ToolDetailsInfoCard({
    super.key,
    required this.titleArabic,
    required this.titleEnglish,
    required this.usage,
    required this.advantage,
  });

  final String titleArabic;
  final String titleEnglish;
  final String usage;
  final String advantage;

  @override
  Widget build(BuildContext context) {
    final hasUsage = usage.trim().isNotEmpty;
    final hasAdvantage = advantage.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF1C2028).withValues(alpha: 0.95),
            const Color(0xFF171717).withValues(alpha: 0.92),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.09),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              titleArabic,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    height: 1.25,
                  ),
            ),
          ),
          if (titleEnglish.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Text(
                titleEnglish,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.82),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF111111).withValues(alpha: 0.58),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (hasUsage) ...[
                    _ToolSectionBadge(
                      title: 'الاستخدام',
                      backgroundColor: const Color(0xFF6BC6FF).withValues(
                        alpha: 0.16,
                      ),
                      borderColor: const Color(0xFF6BC6FF).withValues(alpha: 0.45),
                      textColor: const Color(0xFFD8F2FF),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        usage,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white.withValues(alpha: 0.94),
                              height: 1.75,
                            ),
                      ),
                    ),
                  ],
                  if (hasUsage && hasAdvantage) ...[
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.white.withValues(alpha: 0.08),
                      height: 1,
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (hasAdvantage) ...[
                    _ToolSectionBadge(
                      title: 'الفائدة',
                      backgroundColor: const Color(0xFF8BFFB0).withValues(
                        alpha: 0.16,
                      ),
                      borderColor: const Color(0xFF8BFFB0).withValues(alpha: 0.42),
                      textColor: const Color(0xFFE3FFED),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        advantage,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white.withValues(alpha: 0.94),
                              height: 1.75,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolSectionBadge extends StatelessWidget {
  const _ToolSectionBadge({
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w800,
              ),
        ),
      ),
    );
  }
}
