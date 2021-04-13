import 'package:flutter/material.dart';
import 'package:wallpaperweb/model/image_model.dart';

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
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: GridView.extent(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      maxCrossAxisExtent: 350,
      childAspectRatio: 0.6,
      mainAxisSpacing: 3,
      crossAxisSpacing: 6,
      children: images.map((image) {
        return GridTile(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image.src.portrait,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
