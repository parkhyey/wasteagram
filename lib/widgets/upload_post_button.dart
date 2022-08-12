import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../models/post_model.dart';

Widget uploadPostButton(BuildContext context, GlobalKey<FormState> formkey, 
  PostModel newPost, LocationData? geoData, String? imageURL) {

  return ElevatedButton(
    onPressed: () async {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        var fileName = '${DateTime.now()}.jpg';
        Reference storageReference = FirebaseStorage.instance.ref().child(fileName);       
        await storageReference.putFile(File(imageURL!));
        String url = await storageReference.getDownloadURL();
        FirebaseFirestore.instance.collection('posts').add({
          'date': DateTime.now(),
          'imageURL': url,
          'quantity': newPost.quantity,
          'latitude': geoData!.latitude,
          'longitude': geoData.longitude
        });
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    },
    child: const Icon(Icons.cloud_upload, size: 50),
  );

}