import 'package:fisimate_flutter_app/backup/menu_screen.dart';
import 'package:fisimate_flutter_app/backup/screens/no_interaction_screen.dart';
import 'package:fisimate_flutter_app/backup/screens/orientation_screen.dart';
import 'package:flutter/material.dart';

import 'screens/api_screen.dart';
import 'screens/loader_screen.dart';
import 'screens/simple_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Unity Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(),
        '/simple': (context) => const SimpleScreen(),
        '/loader': (context) => const LoaderScreen(),
        '/orientation': (context) => const OrientationScreen(),
        '/api': (context) => const ApiScreen(),
        '/none': (context) => const NoInteractionScreen(),
      },
    );
  }
}
