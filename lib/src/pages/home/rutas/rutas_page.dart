import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micron/src/data/fire_firestore.dart';
import 'package:micron/src/pages/home/rutas/rutas_controller.dart';

final docTours = FirebaseFirestore.instance.collection("Recorridos");

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  RutasController controller = RutasController();
  FireFirestore fireFirestore = FireFirestore();
  List tours = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.setCustomMapPin();
     // getTours("lineName");
    docTours.snapshots().listen((event) {
      tours.clear();
      for (var doc in event.docs) {
        tours.add(doc.data());
      }
      setState(() {
      });
    });
  }



/*  getTours(String lineName) {
    docTours.snapshots().
    docTours.get().then((QuerySnapshot querySnapshot) {
      tours.clear();
      querySnapshot.docs.forEach((doc) {
        tours.add(doc.data());
        print('received-------------------------------------------------------------');
      });
      setState(() {
        print('update-------------------------------------------------------------');
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final Object? route = ModalRoute.of(context)!.settings.arguments;
    controller.loadRoute(route);
    tours.forEach((bus) {
      if(bus['linea']==controller.lineName){
        controller.loadBus(bus);
      }
    });

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                controller.direction = 'Vuelta';
                controller.loadRoute(route);
              });
            },
            icon: const Icon(Icons.arrow_circle_down),
            label: const Text('Ruta de vuelta'),
            backgroundColor: controller.direction == 'Vuelta'
                ? Colors.indigoAccent
                : Colors.grey,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                controller.direction = 'Ida';
                controller.loadRoute(route);
              });
            },
            icon: const Icon(Icons.arrow_circle_up),
            label: const Text('Ruta de ida'),
            backgroundColor: controller.direction == 'Ida'
                ? Colors.indigoAccent
                : Colors.grey,
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Ruta de ${controller.lineName}"),
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: controller.onMapCreated,
        initialCameraPosition: controller.initialCameraPosition,
        markers: controller.markers,
        polylines: controller.polylines.values.toSet(),
      ),
    );
  }
}
