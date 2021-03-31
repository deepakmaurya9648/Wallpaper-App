import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_admin_app/provider/firebaseOperation.dart';

class UploadImage with ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();

  final picker = ImagePicker();
  File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String uploadPostImageUrl;
  String get getuploadPostImageUrl => uploadPostImageUrl;
  UploadTask imagePostUploadTask;
//!--------------------image picker function--------------
  Future pickImage(BuildContext context) async {
    final uploadPostImageVal =
        await picker.getImage(source: ImageSource.gallery);
    uploadPostImageVal == null
        ? print('Image select')
        : uploadPostImage = File(uploadPostImageVal.path);
    uploadPostImage != null
        ? showPostImage(context)
        : print('Some error ocuured!');
  }

//!---------------------------show post image function----------

  showPostImage(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  color: Colors.black.withOpacity(0.2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    child: Divider(
                      thickness: 4,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: 380,
                    child: Image.file(
                      uploadPostImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          pickImage(context);
                        },
                        color: Colors.black,
                        child: Text(
                          'Reselect',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          uploadImageToFirebase().whenComplete(
                              () => uploadImageToFirestore(context));
                        },
                        color: Colors.black,
                        child: Text(
                          'Comfirm Image',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  //!--------------------upload image to fireStorage-------------------------

  Future uploadImageToFirebase() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');
    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete(() => print('image uploaded'));
    imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }

  uploadImageToFirestore(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  color: Colors.black.withOpacity(0.2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    child: Divider(
                      thickness: 4,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: Column(
                      children: [
                        TextField(
                          controller: name,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        TextField(
                          controller: category,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Category',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.black,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .uploadPostData(name.text, {
                            'name': name.text,
                            'category': category.text,
                            'image_url': getuploadPostImageUrl
                          }).whenComplete(() => Navigator.pop(context));
                        },
                        color: Colors.black,
                        child: Text(
                          'upload',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
