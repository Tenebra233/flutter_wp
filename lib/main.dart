import 'package:flutter/material.dart';
import 'package:flutter_wp_test/screens/login_screen.dart';
import 'package:flutter_wp_test/utility/auth_form_state.dart';
import 'package:flutter_wp_test/utility/wp_registration_api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WpRegistration auth = WpRegistration();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
