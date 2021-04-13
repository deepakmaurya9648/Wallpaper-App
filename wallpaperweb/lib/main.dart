import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperweb/provider/providerClass.dart';
import 'package:wallpaperweb/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}
