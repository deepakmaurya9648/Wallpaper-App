import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_admin_app/provider/uploadImageProvider.dart';

class HomeHelper with ChangeNotifier {
//! ------------------------------appBar--------------------------------------
  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.2),
      elevation: 0,
      title: Text(
        'Images',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<UploadImage>(context, listen: false)
                  .pickImage(context);
            })
      ],
    );
  }

  //!------------------------------Body-----------------------------------
  Widget body(BuildContext context) {
    return Container();
  }
}
