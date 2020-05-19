import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wp_test/utility/auth_form_state.dart';

class WpRegisterWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WebViewController _myController;
    var email =
        Provider.of<RegisterFormState>(context, listen: true).getEmail.text;
    var username =
        Provider.of<RegisterFormState>(context, listen: true).getUsername.text;

    const url =
        'https://testwpflutter.000webhostapp.com/wp-login.php?action=register';
    return WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _myController = controller;
        },
        // javascriptChannels: <JavascriptChannel>[
        //   _toasterJavascriptChannel(context),
        // ].toSet(),
        onPageFinished: (url) async {
          print('Page finished loading: $url');

          await _myController.evaluateJavascript(
              'document.getElementById("user_login").value ="$username"');
          await _myController.evaluateJavascript(
              'document.getElementById("user_email").value ="$email"');
          await _myController.evaluateJavascript(
              'document.getElementById("wp-submit").click()');
        });
  }
}