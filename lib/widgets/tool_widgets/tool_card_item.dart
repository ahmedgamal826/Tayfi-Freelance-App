class BagDetailCardItem {
  const BagDetailCardItem({
    required this.id,
    required this.arabicTitle,
    required this.englishTitle,
    required this.usage,
    required this.advantage,
    required this.imageUrl,
    required this.videoUrl,
  });

  final int id;
  final String arabicTitle;
  final String englishTitle;
  final String usage;
  final String advantage;
  final String imageUrl;
  final String videoUrl;
}
