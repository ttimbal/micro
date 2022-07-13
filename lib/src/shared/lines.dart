import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/fire_firestore.dart';
import 'dart:math';

import 'constants.dart';

class Lines {
  FireFirestore fireFirestore = FireFirestore();
  List _lineas = [];

  final double distance = 3.716971886 * pow(10, -3);



  void loadLines() {
    _lineas = fireFirestore.getLines();
  }

  List get lines=>_lineas;

  List loadLinesThatPassInPosition(LatLng pos) {
    List linesThatPassInPosition = [];
    for (var i = 0; i < _lineas.length; i++) {
      final lineida = _lineas[i]['LI'];
      final lineavuelta = _lineas[i]['LV'];
      bool li = passInPosition(lineida, pos);
      bool lv = passInPosition(lineavuelta, pos);
      if (li || lv) {
        print(_lineas[i]['name']);
        linesThatPassInPosition.add(_lineas[i]);
      }
    }
    return linesThatPassInPosition;
  }

  double distanceAB(LatLng a, LatLng b) {
    double x = (b.longitude - a.longitude);
    double y = (b.latitude - a.latitude);
    double dist = sqrt(pow(x, 2) + pow(y, 2));
    return dist;
  }

  bool passInPosition(dynamic line, LatLng pos) {
    final cordenadas = line['coordenadas'];
    for (var j = 0; j < cordenadas.length; j++) {
      double dist = distanceAB(
          LatLng(cordenadas[j]['latitud'], cordenadas[j]['longitud']), pos);
      if (dist <= distance) {
        return true;
      }
    }
    return false;
  }

  List<List<LatLng>> loadPositions(List lines) {
    List<List<LatLng>> listPositions = [];
    lines.forEach((line) {
      final Li = line['LI'];
      final Lv = line['LV'];
      List<LatLng> listPosition = [];
     // loadParadas(line);
      Li['coordenadas'].forEach((cordenada) {
        LatLng position = LatLng(cordenada['latitud'], cordenada['longitud']);
        listPosition.add(position);
      });
      listPositions.add(listPosition);
    });
    return listPositions;
  }

  Map<PolylineId, Polyline> loadPolylines(List lines) {
    Map<PolylineId, Polyline> polylines={};
    Random rand = Random();
    for (var i = 0; i < lines.length; i++) {
      int randNum = rand.nextInt((colors.length - 1));
      PolylineId polyline1Id = PolylineId("id$i");
      Polyline polyline = Polyline(
        polylineId: polyline1Id,
        points: lines[i],
        color: colors[randNum],
        width: 3,
      );

      polylines[polyline1Id] = polyline;
    }
    return polylines;
  }
}
