import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaperweb/model/image_model.dart';
import 'package:wallpaperweb/widget/widget.dart';

class SearchPage extends StatefulWidget {
  final String searchQuery;

  const SearchPage({this.searchQuery});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String apiKey = "563492ad6f9170000100000122e030dd392345858e56327c25a5d83f";
  List<ImageModel> images = <ImageModel>[];

  getSearchImages(String query) async {
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
    getSearchImages(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: brandName(),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'search wallpaper',
                              border: InputBorder.none),
                        ),
                      ),
                      InkWell(onTap: () {}, child: Icon(Icons.search))
                    ],
                  ),
                ),
              ),
            ),
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
