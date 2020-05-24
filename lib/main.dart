import 'package:flutter/material.dart';
import 'package:flutter_wp_test/screens/home_page.dart';
import 'package:flutter_wp_test/screens/image_upload.dart';
import 'package:flutter_wp_test/screens/login_screen.dart';
import 'package:flutter_wp_test/utility/auth_form_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  SharedPreferences sharedPrefs;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: _getPrefs(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ImageUpload();
              } else {
                return ImageUpload();
              }
            }),
      ),
    );
  }

  Future<String> _getPrefs() async {
    sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString('token');
  }
}
