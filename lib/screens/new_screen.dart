import 'dart:io';
import 'dart:core';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../models/post_model.dart';
import '../widgets/upload_post_button.dart';
import '../widgets/new_post_form.dart';

class NewScreen extends StatefulWidget {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAnalyticsObserver? observer;
  NewScreen({Key? key, required this.observer}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final formkey = GlobalKey<FormState>();
  LocationData? geoData;
  PostModel newPost = PostModel();
  final picker = ImagePicker();
  XFile? image;
  Image? imageFile;
  String? url;
  bool imageSelected = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!imageSelected) {
      return Scaffold(
        appBar: appBarTitle('New Post'),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              cameraButton(), 
              const SizedBox(width: 20), 
              galleryButton()
            ],
          )
        )
      );
    } 
    return Scaffold(
      appBar: appBarTitle('New Post'),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(children: [
            const SizedBox(height: 20),
            Image.file(File(image!.path), height: 250),
            newPostForm(context, newPost),            
          ],),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Semantics(
          button: true,
          enabled: true,
          onTapHint: 'Upload new post',
          child: uploadPostButton(context, formkey, newPost, geoData, image!.path),
        ),
      ),
    );
  }
  
  ElevatedButton cameraButton() {
    return ElevatedButton(
      onPressed: () async {
        sendCurrentTabToAnalytics();
        final pickedFile = await picker.pickImage(source: ImageSource.camera);
        image = XFile(pickedFile!.path);
        imageSelected = true;
        setState(() {});
      }, 
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 120),
        primary: const Color.fromARGB(255, 0, 175, 145),),
      child: const Text('Open\nCamera', textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 20)),
    );
  }

  ElevatedButton galleryButton() {
    return ElevatedButton(
      onPressed: () async {
        sendCurrentTabToAnalytics();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        image = XFile(pickedFile!.path);
        imageSelected = true;
        setState(() {});
      }, 
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 120),
        primary: const Color.fromARGB(255, 0, 175, 145),),
      child: const Text('Open\nGallery', textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 20)),
    );
  }

  AppBar appBarTitle(String title) {
    return AppBar(
      title: const Text('New Post'),
      centerTitle: true,
    );
  }

  void _getLocation() async {
    var locationService = Location();
    geoData = await locationService.getLocation();
  }

  void sendCurrentTabToAnalytics() {
    widget.observer!.analytics.setCurrentScreen(screenName: 'New Screen');
  }

}