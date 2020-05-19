import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter_wp_test/utility/auth_form_state.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

  Future<http.Response> getToken(
      String username, String password, BuildContext context) async {
    // final http.Response response = await http.post('https://www.wokguides.com/wp-json/jwt-auth/v1/token?username=$username&password=$password');
    // print(response.statusCode);
    // return response;
    var url =
        'https://testwpflutter.000webhostapp.com/wp-json/jwt-auth/v1/token';
    // var authorization = 'Basic ' +
    //     base64Encode(utf8.encode(
    //         '$username:$password'));
    var body = jsonEncode({'username': username, 'password': password});

    http
        .post(url,
            headers: {
              "Content-Type": "application/json",
              // 'Authorization': authorization
            },
            body: body)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      // print(json.decode('${response.body}'));
      Map<String, dynamic> responseJson = json.decode('${response.body}');
      Provider.of<RegisterFormState>(context, listen: false).setToken =
          responseJson['token'];

      //Funziona per prendere il token direttamente da provider
      // String a =
      //     (Provider.of<RegisterFormState>(context, listen: false).getToken);
      //     print(a);
    });
  }

  Future<String> getUserNickname(BuildContext context) async {
    var url = 'https://testwpflutter.000webhostapp.com/wp-json/wp/v2/users/me';
    String token =
        Provider.of<RegisterFormState>(context, listen: false).getToken;

    var result = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    });

    // final int statusCode = result.statusCode;
    Map<String, dynamic> responseJson = json.decode('${result.body}');
    return responseJson['name'];
  }

  Future<int> getUserId(BuildContext context) async {
    var url = 'https://testwpflutter.000webhostapp.com/wp-json/wp/v2/users/me';
    String token =
        Provider.of<RegisterFormState>(context, listen: false).getToken;

    var result = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    });

    // final int statusCode = result.statusCode;
    Map<String, dynamic> responseJson = json.decode('${result.body}');
    return responseJson['id'];
  }
}
