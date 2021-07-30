import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future updateUserData(String fname, String lname, String date) async {
    return await userCollection.doc(uid).set({
      'Full Name': fname + ' ' + lname,
      'First Name': fname,
      'Last Name': lname,
      'Register Date': date,
      'User ID': uid,
    });
  }
}

class FirebaseApi {
  static UploadTask? uploadImage(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}

class ItemPost {
  ItemPost({dynamic});
  final CollectionReference sellCollection =
      FirebaseFirestore.instance.collection('sellitems');

  Future postsellitem(String url, String title, int price, String description,
      String username, String useruid) async {
    return await sellCollection.doc(useruid).set({
      'imageURL': url,
      'Title': title,
      'Price': price,
      'Description': description,
      'Seller': username,
      'Seller ID': useruid,
    });
  }
}
// class DataPost {
//   DataPost({dynamic});

//   final CollectionReference gamesCollection =
//       FirebaseFirestore.instance.collection('games');

//   Future uploadDataGames(String username, String input, String dateTime) async {
//     return await gamesCollection.doc().set({
//       'Username': username,
//       'Input': input,
//       'Date': dateTime,
//     });
//   }

//   final CollectionReference businessCollection =
//       FirebaseFirestore.instance.collection('business');

//   Future uploadDataBusiness(
//       String username, String input, String dateTime) async {
//     return await businessCollection.doc().set({
//       'Username': username,
//       'Input': input,
//       'Date': dateTime,
//     });
//   }

//   final CollectionReference healthCollection =
//       FirebaseFirestore.instance.collection('health');

//   Future uploadDataHealth(
//       String username, String input, String dateTime) async {
//     return await healthCollection.doc().set({
//       'Username': username,
//       'Input': input,
//       'Date': dateTime,
//     });
//   }

//   final CollectionReference studyCollection =
//       FirebaseFirestore.instance.collection('study');

//   Future uploadDataStudy(String username, String input, String dateTime) async {
//     return await studyCollection.doc().set({
//       'Username': username,
//       'Input': input,
//       'Date': dateTime,
//     });
//   }
// }
