import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wp_test/utility/wp_registration_api.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wp_test/utility/auth_form_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_wp_test/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
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
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                icon: Icon(Icons.person),
                label: Text('Accedi'))
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
                controller:
                    Provider.of<RegisterFormState>(context, listen: true)
                        .setPassowrd = _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextFormField(
                controller:
                    Provider.of<RegisterFormState>(context, listen: true)
                        .setEmail = _emailController,
                decoration: InputDecoration(labelText: 'Email'),
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
                    "Registrati",
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
                      Future<int> userError = auth.registerUser(
                          _usernameController.text,
                          _passwordController.text,
                          _emailController.text);
                      switch (await userError) {
                        case 400:
                          Provider.of<RegisterFormState>(context, listen: false)
                                  .setErrorToastMessage =
                              'Il nome utente è richiesto';
                          final snackBar = SnackBar(
                            content: SnackBarErrorMessage(),
                          );
                          stopLoading();
                          globalKey.currentState.showSnackBar(snackBar);
                          break;

                        case 401:
                          Provider.of<RegisterFormState>(context, listen: false)
                              .setErrorToastMessage = 'La mail è richiesta';
                          final snackBar = SnackBar(
                            content: SnackBarErrorMessage(),
                          );
                          stopLoading();
                          globalKey.currentState.showSnackBar(snackBar);
                          break;

                        case 404:
                          Provider.of<RegisterFormState>(context, listen: false)
                              .setErrorToastMessage = 'La password è richiesta';
                          final snackBar = SnackBar(
                            content: SnackBarErrorMessage(),
                          );
                          stopLoading();
                          globalKey.currentState.showSnackBar(snackBar);
                          break;

                        case 406:
                          Provider.of<RegisterFormState>(context, listen: false)
                                  .setErrorToastMessage =
                              'Questa email è già registrata';
                          final snackBar = SnackBar(
                            content: SnackBarErrorMessage(),
                          );
                          stopLoading();
                          globalKey.currentState.showSnackBar(snackBar);
                          break;

                        case 200:
                          final snackBar = SnackBar(
                            content: SuccessfulRegistrationSnackBar(),
                          );
                          stopLoading();
                          globalKey.currentState.showSnackBar(snackBar);
                          await Future.delayed(Duration(seconds: 3));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                          break;
                      }

                      stopLoading();
                    }
                  })
            ],
          ),
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

class SnackBarErrorMessage extends StatelessWidget {
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
          Provider.of<RegisterFormState>(context, listen: false)
              .getErrorToastMessage,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class SuccessfulRegistrationSnackBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.check,
          color: Colors.green,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          'Registrazione avvenuta con successo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
