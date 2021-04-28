import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperweb/data/data.dart';
import 'package:wallpaperweb/model/category_model.dart';
import 'package:wallpaperweb/model/image_model.dart';
import 'package:wallpaperweb/views/category.dart';
import 'package:wallpaperweb/views/search.dart';
import 'package:wallpaperweb/widget/widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController seach = TextEditingController();
  String apiKey = "563492ad6f9170000100000122e030dd392345858e56327c25a5d83f";
  List<CategoryModel> category = [];
  List<ImageModel> images = <ImageModel>[];

  getTrandingImages() async {
    var response = await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?per_page=100'),
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
    getTrandingImages();
    category = getCategory();
    super.initState();
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
              padding: const EdgeInsets.only(top: 10),
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
                          autofocus: false,
                          controller: seach,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'search wallpaper',
                              border: InputBorder.none),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            if (seach.text != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPage(
                                            searchQuery: seach.text,
                                          )));
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: category.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    title: category[index].categoryName,
                    imageUrl: category[index].imageUrl,
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: imageList(images: images, context: context))
          ],
        ),
      ),
    );
  }
}

//!------------categoryTile---------------------->
class CategoryTile extends StatelessWidget {
  final String imageUrl, title;

  const CategoryTile({@required this.imageUrl, @required this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryPage(
                      categoryName: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  fit: BoxFit.cover,
                )),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width * 0.2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
