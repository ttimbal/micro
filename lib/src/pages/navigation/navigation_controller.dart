import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micron/src/data/fire_firestore.dart';
import 'package:micron/src/shared/lines.dart';

class NavigationController {
  final lines=Lines();
  double tamCircle = 100;

  LatLng? lugarCirculo;
  Map<CircleId, Circle> myCircle = {};
  List<Marker> myMarkers = [];


  Set<Circle> get getCircle => (myCircle.values.toSet());

  Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  Map<PolylineId, Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines.values.toSet();

  loadLines(){
    lines.loadLines();
  }

  showRoutes(LatLng tappedPoint) {
    _markers.clear();
    myMarkers.add(
      Marker(
          markerId: MarkerId(tappedPoint.toString()), position: tappedPoint),
    );
    List linesThatPassInPosition=lines.loadLinesThatPassInPosition(tappedPoint);
    List<List<LatLng>> positions=lines.loadPositions(linesThatPassInPosition);
    loadStops(linesThatPassInPosition);
    _polylines=lines.loadPolylines(positions);
    showCircle(tappedPoint);
  }

  // show a circle where user clicked
  void showCircle(posicion) {
    print(lines.distance);
    CircleId c = CircleId('1');
    Circle circulo = Circle(
        circleId: c,
        center: posicion,
        radius: tamCircle,
        strokeWidth: 2,
        strokeColor: Colors.blue,
        fillColor: Colors.blue.withAlpha(70));
    myCircle[c] = circulo;
  }


  // markers
  void addMarker(LatLng position, double colorMarker, String infoMarker) {
    MarkerId markerId = MarkerId(position.toString());
    Marker marker = Marker(
      markerId: markerId,
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(colorMarker),
      infoWindow: InfoWindow(
        title: infoMarker,
      ),
      draggable: true,
    );
    _markers[markerId] = marker;
  }

  void loadStops(lines) {
    lines.forEach((data) {
      final Li = data['LI'];
      addMarker(
          LatLng(
              Li["coordenadas"][0]["latitud"],
              Li["coordenadas"][0]["longitud"]),
          BitmapDescriptor.hueRed,
          data['name']);

      addMarker(
          LatLng(Li["coordenadas"][Li["coordenadas"].length - 1]["latitud"],
              Li["coordenadas"][Li["coordenadas"].length - 1]["longitud"]),
          BitmapDescriptor.hueRed,
          data['name']);
      });
  }




}
