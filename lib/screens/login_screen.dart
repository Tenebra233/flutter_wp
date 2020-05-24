import 'dart:convert';
import 'dart:io';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wp_test/screens/home_page.dart';
import 'package:flutter_wp_test/screens/registration_screen.dart';
import 'package:flutter_wp_test/snackbar_notices_message/snackbar_error.dart';
import 'package:flutter_wp_test/utility/auth_form_state.dart';
import 'package:flutter_wp_test/utility/wp_registration_api.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          backgroundColor: Color(0xfffcbf1e),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                icon: Icon(Icons.person),
                label: Text(
                  'Registrati',
                  style: TextStyle(color: Color(0xff120136)),
                ))
          ],
          title: Text(
            'Nome app',
            style: TextStyle(color: Color(0xff120136)),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                controller:
                    Provider.of<RegisterFormState>(context, listen: true)
                        .setUsername = _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                controller:
                    Provider.of<RegisterFormState>(context, listen: true)
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
                  color: Color(0xff035aa6),
                  child: Text(
                    "Accedi",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  loader: Container(
                    padding: EdgeInsets.all(10),
                    child: SpinKitRotatingCircle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: (startLoading, stopLoading, btnState) async {
                    globalKey.currentState.removeCurrentSnackBar();
                    startLoading();

                    final result = await InternetAddress.lookup('example.com');
                    if (result.isEmpty || result[0].rawAddress.isEmpty) {
                      globalKey.currentState.removeCurrentSnackBar();
                      Provider.of<RegisterFormState>(context, listen: false)
                              .setErrorToastMessage =
                          'Non sei connesso ad una rete Internet!';

                      final snackBar = SnackBar(
                        content: SnackBarErrorMessage(),
                      );
                      globalKey.currentState.showSnackBar(snackBar);
                    } else if (_usernameController.text == '' ||
                        _passwordController.text == '') {
                      Provider.of<RegisterFormState>(context, listen: false)
                              .setErrorToastMessage =
                          'Non hai inserito delle credenziali!';
                      stopLoading();
                      final snackBar = SnackBar(
                        content: SnackBarErrorMessage(),
                      );
                      globalKey.currentState.showSnackBar(snackBar);
                    } else {
                      WpRegistration auth = WpRegistration();
                      await auth.getToken(_usernameController.text,
                          _passwordController.text, context);

                      if (await auth.getToken(_usernameController.text,
                              _passwordController.text, context) ==
                          '[jwt_auth] incorrect_password') {
                        Provider.of<RegisterFormState>(context, listen: false)
                            .setErrorToastMessage = 'Password errata';
                        final snackBar = SnackBar(
                          content: SnackBarErrorMessage(),
                        );
                        stopLoading();
                        globalKey.currentState.showSnackBar(snackBar);
                      } else if (await auth.getToken(_usernameController.text,
                              _passwordController.text, context) ==
                          '[jwt_auth] invalid_username') {
                        Provider.of<RegisterFormState>(context, listen: false)
                            .setErrorToastMessage = 'Nome utente non esistente';
                        final snackBar = SnackBar(
                          content: SnackBarErrorMessage(),
                        );
                        stopLoading();
                        globalKey.currentState.showSnackBar(snackBar);
                      } else {
                        await auth.getUserNickname(context);
                        await auth.getUserId(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                        stopLoading();
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
