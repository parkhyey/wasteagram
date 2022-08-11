import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../models/waste_post_DTO.dart';

Widget uploadPostButton(BuildContext context, GlobalKey<FormState> formkey, 
  WastePostDTO newPost, LocationData? geoData, String imageURL) {

  return ElevatedButton(
    onPressed: () async {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        
        var fileName = '${DateTime.now()}.jpg';
        Reference storageReference = FirebaseStorage.instance.ref().child(fileName);       
        await storageReference.putFile(File(imageURL));
        String url = await storageReference.getDownloadURL();
        newPost.latitude = geoData!.latitude;
        newPost.longitude = geoData.longitude;
        newPost.imageURL = url;
        newPost.date = DateTime.now();
        newPost.addToCloud();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    },
    child: const Icon(Icons.cloud_upload, size: 50),
  );

}