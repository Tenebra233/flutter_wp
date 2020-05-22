import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WpRegistration {
  final wp.WordPress wordPress = wp.WordPress(
    baseUrl: 'https://wokguides.com/',
    authenticator: wp.WordPressAuthenticator.JWT,
    adminName: 'admin',
    adminKey: 'admin',
  );

  Future<void> createUser(
      {@required String email,
      @required String username,
      @required String password,
      @required List<String> roles}) async {
    await wordPress
        .createUser(
            user: wp.User(
                email: email,
                password: password,
                username: username,
                roles: roles))
        .then((p) {
      print('User created successfully ${p}');
    }).catchError((err) {
      print('Failed to create user: $err');
    });
  }

  Future<void> authenticateUser(String user, String pass) async {
    Future<wp.User> response = wordPress.authenticateUser(
      username: user,
      password: pass,
    );

    await response.then((user) {
      print(user.name);
      print(user.id.toString());
    }).catchError((err) {
      print('Failed to fetch user: $err');
    });
  }

  Future<String> getToken(
      String username, String password, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    // final http.Response response = await http.post('https://www.wokguides.com/wp-json/jwt-auth/v1/token?username=$username&password=$password');
    // print(response.statusCode);
    var url =
        'https://testwpflutter.000webhostapp.com/wp-json/jwt-auth/v1/token';

    var body = jsonEncode({'username': username, 'password': password});

    var result = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body);
    final int statusCode = result.statusCode;
    Map<String, dynamic> responseJson = json.decode('${result.body}');

    prefs.setString('token', responseJson['token']);

    return statusCode == 403 ? responseJson['code'] : responseJson['token'];
  }

  Future<String> getUserNickname(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var url = 'https://testwpflutter.000webhostapp.com/wp-json/wp/v2/users/me';
    String token = prefs.getString('token');

    var result = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    });

    // final int statusCode = result.statusCode;
    Map<String, dynamic> responseJson = json.decode('${result.body}');
    print(responseJson.toString());
    return responseJson['name'];
  }

  Future<int> getUserId(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var url = 'https://testwpflutter.000webhostapp.com/wp-json/wp/v2/users/me';
    String token = prefs.getString('token');

    var result = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    });

    // final int statusCode = result.statusCode;
    Map<String, dynamic> responseJson = json.decode('${result.body}');
    return responseJson['id'];
  }

  Future<int> registerUser(
      String username, String password, String email) async {
    var url =
        'https://testwpflutter.000webhostapp.com/wp-json/wp/v2/users/register';

    var body = jsonEncode(
        {'username': username, 'password': password, 'email': email});

    var result = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body);
    final int statusCode = result.statusCode;
    Map<String, dynamic> responseJson = json.decode('${result.body}');

    return responseJson['code'];
  }
}
