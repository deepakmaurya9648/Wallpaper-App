import 'package:http/http.dart' as http;
import 'package:wallpaperweb/model/image_model.dart';

class Request {
  String apiKey = "563492ad6f9170000100000122e030dd392345858e56327c25a5d83f";

  Future<List<ImageModel>> getTrandingWallpaper() async {
    try {
      var response = await http.get(
          Uri.parse('https://api.pexels.com/v1/curated?per_page=15'),
          headers: {"Authorization": apiKey});
      if (response.statusCode == 200) {
        var jsonString = response.body;

        //return imageModelFromJson(jsonString);
      }
    } catch (e) {
      return e;
    }
  }
}
