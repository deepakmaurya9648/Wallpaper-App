import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperweb/model/image_model.dart';
import 'package:wallpaperweb/widget/widget.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  CategoryPage({this.categoryName});
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<ImageModel> images = <ImageModel>[];
  String apiKey = "563492ad6f9170000100000122e030dd392345858e56327c25a5d83f";
  getCategoryImages(String query) async {
    var response = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=100'),
        headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      ImageModel imageModel = new ImageModel();
      imageModel = ImageModel.fromMap(element);
      images.add(imageModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getCategoryImages(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: brandName(),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(child: imageList(images: images, context: context))
          ],
        ),
      ),
    );
  }
}
