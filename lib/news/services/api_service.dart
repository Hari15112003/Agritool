import 'dart:convert';

import 'package:agritool/const/api_const.dart';
import 'package:http/http.dart';

import '../model/article_model.dart';

class ApiService {
  final endPointUrl = ApiConstant.newsApi;

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
