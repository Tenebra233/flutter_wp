import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wp_test/screens/login_screen.dart';
import 'package:flutter_wp_test/screens/map_screen.dart';
import 'package:flutter_wp_test/utility/wp_registration_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      ),
                      SizedBox(height: 20.0),
                      FlatButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapScreen()),
                            );
                          },
                          icon: Icon(Icons.map),
                          label: Text(
                            'Vai alla mappa',
                            style: TextStyle(fontSize: 25.0),
                          )),
                      SizedBox(height: 20.0),
                      ArgonButton(
                          height: 50,
                          width: 350,
                          borderRadius: 5.0,
                          color: Colors.black,
                          child: Text(
                            "Disconnetti",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          loader: Container(
                            padding: EdgeInsets.all(10),
                            child: SpinKitRotatingCircle(
                              color: Colors.white,
                              // size: loaderWidth ,
                            ),
                          ),
                          onTap: (startLoading, stopLoading, btnState) async {
                            startLoading();
                            final prefs = await SharedPreferences.getInstance();
                            prefs.remove('token');
                            stopLoading();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          })
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
