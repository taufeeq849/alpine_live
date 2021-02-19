import 'package:alpine_live/app/locator.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/router.gr.dart' as router;

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
              displayColor: Colors.white,
              bodyColor: Colors.black,
              fontFamily: 'OpenSans')),
      initialRoute: router.Routes.homeView,
      onGenerateRoute: router.Router(),
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
