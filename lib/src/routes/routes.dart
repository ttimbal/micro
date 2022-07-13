import 'package:flutter/material.dart';
import 'package:micron/src/pages/pages.dart';

import '../pages/line/line_page.dart';

class Routes {
  static final initialRoute = 'alertPermission';
  static final Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomePage(),
    'alertPermission': (BuildContext context) => const AlertHomePage(),
    'ruta': (BuildContext context) => const RoutesPage(),
    'permission': (BuildContext context) => const RequestPermissionPage(),
    'line': (BuildContext context) => const LinePage(),
  };

  static final routesName = {
    'home': 'home',
    'alertPermission': 'alertPermission',
    'ruta': 'ruta',
    'permission': 'permission',
    'line': 'line',
  };
}
