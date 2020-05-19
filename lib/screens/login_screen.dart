import 'dart:convert';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:flutter_wp_test/screens/home_page.dart';
import 'package:flutter_wp_test/screens/registration_screen.dart';
import 'package:flutter_wp_test/utility/auth_form_state.dart';
import 'package:flutter_wp_test/utility/wp_registration_api.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
        title: Text('Logga utente test'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: Provider.of<RegisterFormState>(context, listen: true)
                  .setUsername = _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              obscureText: true,
              controller: Provider.of<RegisterFormState>(context, listen: true)
                  .setPassowrd = _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(
              height: 10.0,
            ),
            ArgonButton(
              height: 50,
              width: 350,
              borderRadius: 5.0,
              color: Colors.black,
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              loader: Container(
                padding: EdgeInsets.all(10),
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                  // size: loaderWidth ,
                ),
              ),
              onTap: (startLoading, stopLoading, btnState) async {
                if (btnState == ButtonState.Idle) {
                  startLoading();
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult != ConnectivityResult.wifi &&
                      connectivityResult != ConnectivityResult.mobile) {
                    globalKey.currentState.removeCurrentSnackBar();

                    final snackBar = SnackBar(
                      content: NoInternetError(),
                    );
                    globalKey.currentState.showSnackBar(snackBar);
                  } else {
                    WpRegistration auth = WpRegistration();
                    await auth.getToken(_usernameController.text,
                        _passwordController.text, context);
                    await auth.getUserNickname(context);
                    await auth.getUserId(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                    stopLoading();
                  }

                  // var url =
                  //     'https://wokguides.com/wp-json/remote-login/login';
                  // var authorization = 'Basic ' +
                  //     base64Encode(utf8.encode(
                  //         '${_usernameController.text}:${_passwordController.text}'));
                  // var body = jsonEncode({
                  //   'username': _usernameController.text,
                  //   'password': _passwordController.text
                  // });

                  // http
                  //     .post(url,
                  //         headers: {
                  //           "Content-Type": "application/json",
                  //           'Authorization': authorization
                  //         },
                  //         body: body)
                  //     .then((http.Response response) {
                  //   final int statusCode = response.statusCode;
                  //   if (statusCode == 200) {
                  //     print('ok');
                  //   }
                  //   else{
                  //     print('no');
                  //   }
                  // });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NoInternetError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          'Non sei connesso ad una rete Internet!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
