import 'package:flutter/material.dart';
import 'package:flutter_wp_test/utility/auth_form_state.dart';
import 'package:provider/provider.dart';

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
