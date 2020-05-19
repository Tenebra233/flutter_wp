import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RegisterFormState extends ChangeNotifier {
  TextEditingController _email;
  TextEditingController _username;
  TextEditingController _password;
  String _token;

  TextEditingController get getEmail {
    return _email;
  }

  TextEditingController get getUsername {
    return _username;
  }

  TextEditingController get password {
    return _password;
  }

  String get getToken {
    return _token;
  }

  set setToken(token) {
    _token = token;
  }

  set setUsername(TextEditingController username) {
    _username = username;
    notifyListeners();
  }

  set setEmail(TextEditingController email) {
    _email = email;
    notifyListeners();
  }

  set setPassowrd(TextEditingController password) {
    _password = password;
    notifyListeners();
  }
}
