import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../models/food_waste_post_DTO.dart';

 Widget bottomAppBar(BuildContext context, GlobalKey<FormState> formkey, 
  FoodWastePostDTO newPost, LocationData? geoData, String imageURL) {

  return BottomAppBar(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Semantics(
        button: true,
        label: 'Save new post',
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),),
          onPressed: () {
            if (formkey.currentState!.validate()) {
              formkey.currentState!.save();
              newPost.latitude = geoData!.latitude;
              newPost.longitude = geoData.longitude;
              newPost.imageURL = imageURL;
              newPost.date = DateTime.now();
              //create post and save to Firebase
              newPost.addToCloud();
              Navigator.of(context).pop();
            }
          },
          child: const Icon(Icons.cloud_upload, size: 50)
        )
      )
    )
  );

}