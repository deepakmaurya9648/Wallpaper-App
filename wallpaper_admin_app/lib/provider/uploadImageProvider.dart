import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage with ChangeNotifier {
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
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
                  height: MediaQuery.of(context).size.height * 0.38,
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
                        uploadImageToFirebase();
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
}
