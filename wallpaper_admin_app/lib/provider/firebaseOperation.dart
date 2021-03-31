import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseOperation with ChangeNotifier {
  Future uploadPostData(String postId, dynamic data) async {
    print('data posted');
    return FirebaseFirestore.instance.collection('image').doc(postId).set(data);
  }
}
