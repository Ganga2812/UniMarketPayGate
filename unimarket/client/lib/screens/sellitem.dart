import 'dart:ffi';
import 'dart:io';
import 'package:client/services/database.dart';
import 'package:client/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'package:client/screens/home.dart';
import 'package:client/shared/appbar.dart';
import 'package:client/shared/constants.dart';
import 'package:client/shared/drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellItem extends StatefulWidget {
  const SellItem({Key? key}) : super(key: key);

  @override
  _SellItemState createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  final ItemPost _item = ItemPost();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Variable for data
  late String iname;
  late int iprice;
  late String idescript;
  String error = '';

  // Variable for image
  File? imageFile;
  var isInitialized = false;
  String? fileName;
  UploadTask? task;
  String? uploadURL;

  //Variable for username and uid
  User user = FirebaseAuth.instance.currentUser!;
  String username = '';
  String useruid = '';

  void getUserNameAndUID(documentId) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    users.doc(documentId).get().then((DocumentSnapshot documentSnapshot) {
      setState(() => username = documentSnapshot.get('Full Name'));
    });
    users.doc(documentId).get().then((DocumentSnapshot documentSnapshot) {
      setState(() => useruid = documentSnapshot.get('User ID'));
    });
  }

  selectImage() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _uploadImage() async {
    if (imageFile == null) {
      print('No file');
      return;
    }
    final fileName = basename(imageFile!.path);
    final destination = 'images/$fileName';
    task = FirebaseApi.uploadImage(destination, imageFile!);
    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      uploadURL = urlDownload;
    });
    return uploadURL;
  }

  @override
  Widget build(BuildContext context) {
    getUserNameAndUID(user.uid);
    final fileName = imageFile != null ? basename(imageFile!.path) : '';
    // _uploadImage();
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBarCommon(
              title: Text(''),
              appBar: AppBar(),
              onpress: () async {
                Navigator.pop(
                    context, MaterialPageRoute(builder: (_) => Home()));
              },
              label: Text("Cancel"),
              icon: Icon(Icons.cancel),
            ),
            drawer: DrawerCommon(),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15)),
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 300,
                              child: imageFile == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ListTile(
                                            // leading: Icon(Icons.add_a_photo_outlined),
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_a_photo_outlined,
                                                  size: 30,
                                                ),
                                              ],
                                            ),
                                            subtitle: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Add Photo from Library',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            onTap: () async {
                                              await selectImage();
                                            }),
                                      ],
                                    )
                                  : Container(
                                      child: Image.file(
                                        imageFile!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                            ),
                          ),

                          //Image name when picture is chosen
                          // Text(
                          //   fileName,
                          // ),

                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Item\'s Name required' : null,
                            onChanged: (value) {
                              setState(() => iname = value);
                            },
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Title',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            validator: (value) => value!.isEmpty
                                ? 'Item\'s Price required'
                                : null,
                            onChanged: (value) {
                              setState(() {
                                iprice = int.parse(value);
                              });
                            },
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Price',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) => value!.isEmpty
                                ? 'Item\'s Description required'
                                : null,
                            onChanged: (value) {
                              setState(() => idescript = value);
                            },
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Description',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            error,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 250,
                            child: RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  await _uploadImage();

                                  if (uploadURL == null) {
                                    setState(() {
                                      error =
                                          'Image is required\nor\nUnable to upload the picture';
                                      setState(() => loading = false);
                                    });
                                  }
                                  await _item.postsellitem(uploadURL!, iname,
                                      iprice, idescript, username, useruid);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Home()));
                                }
                              },
                              child: Text('Sell this Item',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF), fontSize: 17)),
                              color: Color(0xFF29BF12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
