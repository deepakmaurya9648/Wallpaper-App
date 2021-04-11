import 'package:flutter/material.dart';
import 'package:wallpaperweb/data/data.dart';
import 'package:wallpaperweb/model/category_model.dart';
import 'package:wallpaperweb/widget/widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> category = [];
  @override
  void initState() {
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
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'search wallpaper',
                              border: InputBorder.none),
                        ),
                      ),
                      Icon(Icons.search)
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
            )
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
    return Container(
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
            color: Colors.black26,
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * 0.2,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
