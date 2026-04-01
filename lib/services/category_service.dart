import 'dart:convert';
import 'dart:io';

import 'package:tayfi/widgets/tool_widgets/tool_card_item.dart';
import 'package:tayfi/widgets/home_widgets/tool_item.dart';

class CategoryService {
  static const String _categoriesUrl = 'http://tayfi.runasp.net/api/Category';

  static const List<String> _bagImages = [
    'assets/images/purpleBag.png',
    'assets/images/greenImage.png',
    'assets/images/orangeBag.png',
    'assets/images/blueBag.png',
    'assets/images/yellowBag.png',
    'assets/images/blackBag.png',
    'assets/images/pinkBag.png',
    'assets/images/redBag.png',
  ];

  Future<List<BagItem>> fetchCategories() async {
    final decoded = await _getDecodedJson(_categoriesUrl);

    if (decoded is! List) {
      throw const FormatException('Unexpected categories response format');
    }

    return decoded.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      if (item is! Map<String, dynamic>) {
        throw const FormatException('Invalid category item format');
      }

      final arabicTitle = (item['name'] as String? ?? '').trim();
      final englishTitle = (item['description'] as String? ?? '').trim();

      return BagItem(
        id: item['id'] as int? ?? index,
        arabicTitle: arabicTitle,
        englishTitle: englishTitle,
        imagePath: _bagImages[index % _bagImages.length],
      );
    }).toList();
  }

  Future<CategoryDetails> fetchCategoryDetails(int categoryId) async {
    final decoded = await _getDecodedJson('$_categoriesUrl/$categoryId');

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Unexpected category details response format');
    }

    final tools = decoded['tools'];
    if (tools is! List) {
      throw const FormatException('Category tools list is missing');
    }

    return CategoryDetails(
      id: decoded['id'] as int? ?? categoryId,
      arabicTitle: (decoded['name'] as String? ?? '').trim(),
      englishTitle: (decoded['description'] as String? ?? '').trim(),
      tools: tools.map((tool) {
        if (tool is! Map<String, dynamic>) {
          throw const FormatException('Invalid tool item format');
        }

        return BagDetailCardItem(
          id: tool['id'] as int? ?? 0,
          arabicTitle: (tool['name'] as String? ?? '').trim(),
          englishTitle: (tool['description'] as String? ?? '').trim(),
          usage: (tool['usage'] as String? ?? '').trim(),
          advantage: (tool['advantage'] as String? ?? '').trim(),
          imageUrl: (tool['image'] as String? ?? '').trim(),
          videoUrl: (tool['link'] as String? ?? '').trim(),
        );
      }).toList(),
    );
  }

  Future<dynamic> _getDecodedJson(String url) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();

      if (response.statusCode != 200) {
        throw HttpException(
          'Failed to load data: ${response.statusCode}',
          uri: Uri.parse(url),
        );
      }

      final responseBody = await response.transform(utf8.decoder).join();
      return jsonDecode(responseBody);
    } finally {
      client.close(force: true);
    }
  }
}

class CategoryDetails {
  const CategoryDetails({
    required this.id,
    required this.arabicTitle,
    required this.englishTitle,
    required this.tools,
  });

  final int id;
  final String arabicTitle;
  final String englishTitle;
  final List<BagDetailCardItem> tools;
}
