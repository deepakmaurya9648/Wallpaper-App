import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({this.imgUrl});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            Hero(
              tag: widget.imgUrl,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image.network(
                    widget.imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      final ByteData imageData =
                          await NetworkAssetBundle(Uri.parse("YOUR_URL"))
                              .load("");
                      final Uint8List bytes = imageData.buffer.asUint8List();
// display it with the Image.memory widget
                      Image.memory(bytes);
                    },
                    child: Container(
                      height: 60,
                      width: 200,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.grey.withOpacity(0.4)
                          ])),
                      child: Column(
                        children: [
                          Text("Set Wallpaper",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          Text("Image will be saved in gallery",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 90,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
