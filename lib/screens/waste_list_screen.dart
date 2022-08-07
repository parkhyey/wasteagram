import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'new_waste_screen.dart';
import '../widgets/list_posts.dart';
import '../widgets/find_sum.dart';

class WasteListScreen extends StatefulWidget {

  FirebaseStorage storage = FirebaseStorage.instance;
  WasteListScreen({Key? key}) : super(key: key);

  @override
  State<WasteListScreen> createState() => _WasteListScreenState();

}

class _WasteListScreenState extends State<WasteListScreen> {

  File? image;
  int sum = 0;

  // pick an image from the gallery, upload it to Firebase Storage and return 
  // the URL of the image in Firebase Storage.
  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: const Text('Wasteagram')
      ),
      body: ListPosts(),      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Select an image' ,
        child: FloatingActionButton(
          onPressed: () async {
            String imageURL = await getImage();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewWasteScreen(imageURL: imageURL)));
          },
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }

}
