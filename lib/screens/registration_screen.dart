import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wp_test/utility/auth_form_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_wp_test/screens/wp_register_webview.dart';
import 'package:flutter_wp_test/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
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
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: Icon(Icons.person),
              label: Text('Login'))
        ],
        title: Text('Crea utente test'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: Provider.of<RegisterFormState>(context, listen: true)
                  .setEmail = _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: Provider.of<RegisterFormState>(context, listen: true)
                  .setUsername = _usernameController,
              decoration: InputDecoration(labelText: 'Nome utente'),
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton.icon(
                onPressed: () async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WpRegisterWebView()),
                    );
                  }
                },
                icon: Icon(
                  Icons.check,
                  size: 40.0,
                ),
                label: Text(''))
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
