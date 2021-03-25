import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_admin_app/screens/homePageProvider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Provider.of<HomeHelper>(context, listen: false).appBar(context),
    );
  }
}
