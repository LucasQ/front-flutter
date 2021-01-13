import 'dart:convert';

import 'package:flutterApp/models/cardModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'authRepository.dart';

class EventRepository {
  static Future<List<CardModel>> getEvents() async {
    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("accessToken") ?? "");
    String url = 'http://10.0.2.2:9900/info/events';
    var result;
    var header = getHeader(token);

    var response = await http.get(url, headers: header);

    if (response.statusCode == 403) {
      await AuthRepository.refreshToken();
      token = (prefs.getString("accessToken") ?? "");
      header = getHeader(token);
      var refreshResponse = await http.get(url, headers: header);
      result = responseToModel(json.decode(refreshResponse.body));
    } else {
      result = responseToModel(json.decode(response.body));
    }
    return result;
  }

  static responseToModel(List listReponse) {
    final events = List<CardModel>();
    CardModel event;

    for (Map item in listReponse) {
      event = CardModel.fromJson(item);
      events.add(event);
    }
    return events;
  }

  static getHeader(String token) {
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    return header;
  }
}
