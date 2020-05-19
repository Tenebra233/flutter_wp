import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wp_test/utility/wp_registration_api.dart';

class HomeScreen extends StatelessWidget {
  final WpRegistration wp = WpRegistration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future:
              Future.wait([wp.getUserNickname(context), wp.getUserId(context)]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Benvenuto, ${snapshot.data[0]}',
                        style: TextStyle(fontSize: 22.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Il tuo ID è ${snapshot.data[1]}',
                        style: TextStyle(fontSize: 22.0),
                      )
                    ],
                  ),
                );
              }
            } else {
              return Center(child: SpinKitCircle(color: Colors.black));
            }
          },
        ),
      ),
    );
  }
}
