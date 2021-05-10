import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io' as io;

import '../local_storage.dart';

final LocalStorage _varStorage = LocalStorage();

class UpLoadFile {
  static Future<UploadTask> uploadFile(File file, String type) async {
    if (file == null) {
      /* ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));*/
      return null;
    }

    UploadTask uploadTask;
    Reference ref = FirebaseStorage.instance.ref();

    switch (type) {
      case 'logo':
        String id = await _varStorage.getOrgId();

        ref = ref.child('$id org').child('/logo.jpg');

        break;
    }

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }

  static Future<String> getUrlImg() async {
    String id = await _varStorage.getOrgId();

    var ref =
        FirebaseStorage.instance.ref().child('$id org').child('/logo.jpg');
    ;

    String location = await ref.getDownloadURL();
    return location;
  }
}

class StorageManagerCommends {
  static final FirebaseStorage storage = FirebaseStorage.instance;
  /* static StorageReference user(String userID) => storage.ref().child('User').child(userID);
  static StorageReference items(String userID) => user(userID).child("Item");
  static StorageReference item(String userID, String itemID) => items(userID).child(itemID);
  static StorageReference itemImages(String userID, String itemID) =>
      item(userID, itemID).child('Image');*/
}
