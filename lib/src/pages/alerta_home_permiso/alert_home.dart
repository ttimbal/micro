import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'alert_home_controller.dart';

class AlertHomePage extends StatefulWidget {
  const AlertHomePage({Key? key}) : super(key: key);

  @override
  State<AlertHomePage> createState() => _AlertHomePageState();
}

class _AlertHomePageState extends State<AlertHomePage> {
  final _controller = AlertHomeController(Permission.locationWhenInUse);

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller.checkPermission();
      _controller.addListener(() {
        if (_controller.routeName != null) {
          Navigator.pushReplacementNamed(context, _controller.routeName!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
          CircularProgressIndicator(),
      ],
    )

    );
  }
}
