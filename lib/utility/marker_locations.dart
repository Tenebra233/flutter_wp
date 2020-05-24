import 'package:flutter/material.dart';
import 'package:flutter_wp_test/screens/image_upload.dart';
import 'package:flutter_wp_test/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerLocations {
  MarkerLocations();
  final quartiereMedioevale = Marker(
      markerId: MarkerId('quartiereMedioevale'),
      // position: _lastMapPosition,
      position: LatLng(42.4690242, 12.1737592),
      infoWindow: InfoWindow(
        title: "Quartiere medioevale di Vitorchiano",
        snippet: "L'antico quartiere medioevale di Vitorchiano",
        onTap: () {},
      ),
      onTap: () {
      },
      icon: BitmapDescriptor.defaultMarker);

  final statuaMoai = (Marker(
      markerId: MarkerId('statuaMoai'),
      // position: _lastMapPosition,
      position: LatLng(42.4711982, 12.1731659),
      infoWindow: InfoWindow(
          title: "Statua Moai di Vitorchiano",
          snippet: "Sto coso è orribile non guardatelo mette angoscia",
          onTap: () {}),
      onTap: () {},
      icon: BitmapDescriptor.defaultMarker));
  final chiesaSantaMaria = (Marker(
      markerId: MarkerId('chiesaSantaMaria'),
      // position: _lastMapPosition,
      position: LatLng(42.469718, 12.1734598),
      infoWindow: InfoWindow(
          title: "Chiesa Santa Maria assunta in Cielo",
          snippet: "L'ennesima chiesa",
          onTap: () {}),
      onTap: () {},
      icon: BitmapDescriptor.defaultMarker));
}
