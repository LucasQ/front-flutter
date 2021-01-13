import 'dart:convert';

import 'package:flutterApp/models/userModel.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static Future createToken(String name) async {
    var prefs = await SharedPreferences.getInstance();

    String url = 'http://10.0.2.2:9900/auth/login';

    var header = {"Content-Type": "application/json"};

    Map param = {"username": name};

    var _body = json.encode(param);

    try {
      var response = await http.post(url, headers: header, body: _body);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        prefs.setString("accessToken", mapResponse["accessToken"]);
        prefs.setString("refreshToken", mapResponse["refreshToken"]);
      }
    } catch (e) {
      print(e.message);
    }
  }

  static Future refreshToken() async {
    var prefs = await SharedPreferences.getInstance();

    String url = 'http://10.0.2.2:9900/auth/refresh';
    String refreshToken = (prefs.getString("refreshToken") ?? "");

    var header = {"Content-Type": "application/json"};
    Map param = {"token": "$refreshToken"};

    var _body = json.encode(param);
    try {
      var response = await http.post(url, headers: header, body: _body);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        prefs.setString("accessToken", mapResponse["accessToken"]);
      }
    } catch (e) {
      print(e.message);
    }
  }

  static Future<dynamic> googleSignUp(getNewsList) async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      User user = User(
          name: googleUser.displayName,
          email: googleUser.email,
          photourl: googleUser.photoUrl);

      var prefs = await SharedPreferences.getInstance();
      prefs.setStringList("user", user.toStringList());

      await AuthRepository.createToken(user.name);
      await getNewsList();

      return user;
    } catch (e) {
      print(e.message);
    }
  }

  static Future<dynamic> signUpWithFacebook(getNewsList) async {
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=$token');
        final profile = json.decode(graphResponse.body);

        User user = User(
            name: profile["name"],
            email: profile["email"],
            photourl: profile["picture"]["data"]["url"]);

        var prefs = await SharedPreferences.getInstance();
        prefs.setStringList("user", user.toStringList());

        await AuthRepository.createToken(user.name);
        await getNewsList();

        return user;
      }
    } catch (e) {
      print(e.message);
    }
  }
}
