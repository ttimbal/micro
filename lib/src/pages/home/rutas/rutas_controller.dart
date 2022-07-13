import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/map_style.dart';

class RutasController {
  Set<Marker> markers = {};
  Set<Marker> busMarkers = {};
  String lineName = "";
  String direction='Ida';

  final Map<PolylineId, Polyline> polylines = {};

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(-17.783113, -63.181359),
    zoom: 14.2,
  );
  List<LatLng> listPosition = [];
  dynamic pinLocationIcon;



  void addMarker(LatLng position, double colorMarker, String infoMarker) {
    markers.add(Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      icon: infoMarker=='micro'?pinLocationIcon:BitmapDescriptor.defaultMarkerWithHue(colorMarker),
      infoWindow: InfoWindow(
        title: infoMarker,
      ),
      draggable: true,
    ));
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1),
        'assets/icon_bus.png');
  }
  void loadRoute(route){
    lineName = route['name'];
    loadPositions(route);
    loadStops(route);
    loadPolylines();
    //loadBus();
  }

  void loadBus(bus){
   /* print("mostrando bus------------------------------------------------");
    print(bus["latitud"]);
    print(bus["longitud"]);*/
    addMarker(
        LatLng(bus["latitud"], bus["longitud"]),
     // LatLng(-17.7759591,-63.1816487),
        //-17.7819343,-63.1871239
        BitmapDescriptor.hueRed,
        "micro");
  }

  void loadStops(data) {
    markers.clear();
    final coordinates = direction=='Ida'?data['LI']:data['LV'];
    //linea de ida
    addMarker(
        LatLng(
            coordinates["coordenadas"][0]["latitud"], coordinates["coordenadas"][0]["longitud"]),
        BitmapDescriptor.hueRed,
        "Parada Inicio");

    addMarker(
        LatLng(coordinates["coordenadas"][coordinates["coordenadas"].length - 1]["latitud"],
            coordinates["coordenadas"][coordinates["coordenadas"].length - 1]["longitud"]),
        BitmapDescriptor.hueGreen,
        "Parada Fin");
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  void loadPositions(data) {
    listPosition.clear();
    final coordinates = direction=='Ida'?data['LI']:data['LV'];

    coordinates['coordenadas'].forEach((cordenada) {
      LatLng position = LatLng(cordenada['latitud'], cordenada['longitud']);
      listPosition.add(position);
    });
  }

  void loadPolylines() {
    polylines.clear();
    PolylineId polylineId = const PolylineId('id1');

    Polyline polyline = Polyline(
      polylineId: polylineId,
      points: listPosition,
      color: Colors.blue,
      width: 3,

    );

    polylines[polylineId] = polyline;
  }

}
