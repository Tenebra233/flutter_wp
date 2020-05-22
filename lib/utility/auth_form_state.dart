import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RegisterFormState extends ChangeNotifier {
  TextEditingController _email;
  TextEditingController _username;
  TextEditingController _password;
  String _token;
  String _errorToastMessage;

  //Stringa che vale 0 o 1
  String _loginStatusCodeError;

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

  String get getErrorToastMessage {
    return _errorToastMessage;
  }

  String get getLoginStatusCodeError {
    return _loginStatusCodeError;
  }

  set setLoginStatusCodeError(error) {
    _loginStatusCodeError = error;
  }

  set setErrorToastMessage(message) {
    _errorToastMessage = message;
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
