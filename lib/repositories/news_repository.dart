import 'dart:convert';

import 'package:bloc_news/modals/article_modal.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<List<ArticleModal>> fetchNews() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=ab3b6086568c4c00ad6c843bf2aa2cf5"));
    var data = jsonDecode(response.body);
    List<ArticleModal> articleModalList = [];
    if (response.statusCode == 200) {
      for (var item in data["articles"]) {
        ArticleModal articleModal = ArticleModal.fromJson(item);
        articleModalList.add(articleModal);
      }
      return articleModalList;
    } else {
      return articleModalList; // empty list
    }
  }
}
