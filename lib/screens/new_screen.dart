import 'dart:io';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../models/waste_post_DTO.dart';
import '../widgets/bottom_appbar.dart';

class NewScreen extends StatefulWidget {
  FirebaseStorage storage = FirebaseStorage.instance;
  NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final formkey = GlobalKey<FormState>();
  LocationData? geoData;
  WastePostDTO newPost = WastePostDTO();
  int? quantity;
  XFile? image;
  final picker = ImagePicker();
  String? url;
  bool imageSelected = false;
  Image? imageFile;

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
            TextFormField(
              textAlign: TextAlign.center, 
              autofocus: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Number of Wasted Items',
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 25.0, height: 2.0),
              onSaved: (value) {
                newPost.quantity = int.tryParse(value!); },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the number of items.';
                }
                return null;
              },
            ),
            
          ],),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Semantics(
          button: true,
          enabled: true,
          onTapHint: 'Upload a post',
          child: uploadPostButton(context, formkey, newPost, geoData, image!.path),
        ),
      ),
    );
  }
  
  ElevatedButton cameraButton() {
    return ElevatedButton(
      onPressed: () async {
        final pickedFile = await picker.pickImage(source: ImageSource.camera);
        image = XFile(pickedFile!.path);
        imageSelected = true;
        setState(() {});
      }, 
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 120)),
      child: const Text('Open\nCamera', textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 20)),
    );
  }

  ElevatedButton galleryButton() {
    return ElevatedButton(
      onPressed: () async {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        image = XFile(pickedFile!.path);
        imageSelected = true;
        setState(() {});
      }, 
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 120)),
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

}