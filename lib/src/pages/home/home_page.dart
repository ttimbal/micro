import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:micron/src/pages/navigation/navigation_page.dart';
import 'home_controller.dart';
import 'lineas/lineas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();
  int _optionSelected = 0;
  final List<Widget> pages = [
    const LineasPage(),
    const NavigationPage(),
  ];
  @override
  Widget build(BuildContext context) {
    _controller.init();
    if (false) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                  'Para usar la app nesecitamos acceder a tu ubicación,\n habilita el GPS',
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Geolocator.openLocationSettings();
                  });
                },
                child: const Text('Ir a Habilitar GPS'),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: pages.elementAt(_optionSelected),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus),
              label: 'Lineas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Navegar',
            )
          ],
          currentIndex: _optionSelected,
          selectedItemColor: Colors.blue,
          onTap: (value) {
            setState(() {
              _optionSelected = value;
            });
          },
        ),
      );
    }
  }
}
