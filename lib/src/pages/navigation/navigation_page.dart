import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micron/src/pages/navigation/navigation_controller.dart';
import '../../utils/map_style.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final navigationController = NavigationController();

  @override
  Widget build(BuildContext context) {
    navigationController.loadLines();

    return Scaffold(
        appBar: AppBar(
          title: Text("Navegación"),
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(mapStyle);
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: LatLng(-17.78629, -63.18117),
                zoom: 12.4746,
              ),
              onTap: _handleTap,
              markers: navigationController.markers,
              polylines: navigationController.polylines,
              circles: navigationController.getCircle,
            ),
          ],
        ));
  }

  _handleTap(LatLng tappedPoint) {
    Navigator.pushNamed(
      context,
      'line',
      arguments: tappedPoint,
    );
/*    setState(() {
      navigationController.showRoutes(tappedPoint);
    });*/
  }

/*  void _agrandarCirculo() {
    setState(() {
      if (tamCircle == 400) {
        tamCircle = 100;
      } else {
        tamCircle = tamCircle + 100;
      }
      cargarCircle(lugarCirculo);
    });
  }*/

/*  void _circuloEnMiUbicacion() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled!) return;
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted != PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }
    _locationData = await location.getLocation();
    setState(() {
      _isGetLocation = true;
      final p = LatLng(_locationData!.latitude!, _locationData!.longitude!);
      lugarCirculo = p;
      cargarCircle(p);
      _controllerDistance.addLinesOnCircle(p);
      _controllerLineas.cargarLista(_controllerDistance.lineasOnCircle);
      _controllerLineas.uploadRoute();
    });
  }*/

/*  Widget button(function, IconData icon, String description) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: Colors.blue,
      child: Tooltip(
          message: description,
          child: Icon(
            icon,
            size: 30.0,
          )),
    );
  }*/

}
