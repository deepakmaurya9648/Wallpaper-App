import 'package:flutter/material.dart';

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
