import 'package:flutter/material.dart';

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
