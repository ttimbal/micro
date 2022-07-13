import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micron/src/pages/line/line_controller.dart';

import '../../shared/constants.dart';

class LinePage extends StatefulWidget {
  const LinePage({Key? key}) : super(key: key);

  @override
  State<LinePage> createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  @override
  Widget build(BuildContext context) {
    final lineController = LineController();
    final LatLng? position =
        ModalRoute.of(context)!.settings.arguments as LatLng?;
    lineController.loadLines();
    List lines = lineController.lines.loadLinesThatPassInPosition(position!);

    return Scaffold(
        appBar: AppBar(
          title: Text("Navegación"),
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
        ),
        body: Container(
            child: ListView.builder(
          itemCount: lines.length,
          itemBuilder: (context, index) => Card(
            elevation: 6,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(images[lines[index]["name"]] ?? ''),
                backgroundColor: Colors.transparent,
              ),
              title: Text(lines[index]["name"]),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'ruta',
                  arguments: lines[index],
                );
              },
            ),
          ),
        )));
  }
}
