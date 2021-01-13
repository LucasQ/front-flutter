import 'dart:convert';

import 'package:flutterApp/models/cardModel.dart';
import 'package:http/http.dart' as http;

import 'authRepository.dart';

class NewsRepository {
  static Future<List<CardModel>> getNews() async {
    String url = 'http://10.0.2.2:9900/info/news';

    var response = await http.get(url);

    List listReponse = json.decode(response.body);

    final news = List<CardModel>();

    CardModel nm;

    for (Map item in listReponse) {
      nm = CardModel.fromJson(item);
      news.add(nm);
    }

    return news;
  }
}
