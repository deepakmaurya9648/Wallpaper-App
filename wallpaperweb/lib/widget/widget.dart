import 'package:flutter/material.dart';
import 'package:wallpaperweb/model/image_model.dart';
import 'package:wallpaperweb/views/image_views.dart';

Widget brandName() {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
            ),
            Text(
              'Wallpaper',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5),
            ),
            Text(
              'Demo',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5),
            )
          ],
        );
        //!--------------------mobile views--------------
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Wallpaper',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'Demo',
              style: TextStyle(
                  color: Colors.deepPurple, fontWeight: FontWeight.bold),
            )
          ],
        );
      }
    },
  );
}

Widget imageList({List<ImageModel> images, context}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GridView.count(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            childAspectRatio: 0.6,
            mainAxisSpacing: 3,
            crossAxisSpacing: 6,
            children: images.map((image) {
              return GridTile(
                child: Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageView(
                                    imgUrl: image.src.landscape,
                                  )));
                    },
                    child: Hero(
                      tag: image.src.portrait,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          image.src.portrait,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GridView.count(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 3,
            crossAxisSpacing: 6,
            children: images.map((image) {
              return GridTile(
                child: Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageView(
                                    imgUrl: image.src.portrait,
                                  )));
                    },
                    child: Hero(
                      tag: image.src.portrait,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          image.src.portrait,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
    },
  );
}
