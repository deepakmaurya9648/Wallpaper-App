import 'package:flutter/material.dart';
import 'package:wallpaperweb/model/image_model.dart';
import 'package:wallpaperweb/request/request.dart';

class ProviderClass with ChangeNotifier {
  List<ImageModel> imageList = <ImageModel>[];
  Request request = Request();
  List<ImageModel> get image => imageList;

  void getImage() async {
    var images = await request.getTrandingWallpaper();
    imageList = images;
    print(imageList[0].photographer);
    notifyListeners();
  }
}
