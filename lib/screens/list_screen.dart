import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/list_builder.dart';
import '../widgets/total_sum.dart';
import 'new_screen.dart';

class ListScreen extends StatefulWidget {

  FirebaseStorage storage = FirebaseStorage.instance;
  ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();

}

class _ListScreenState extends State<ListScreen> {

  File? image;
  int sum = 0;

  // pick an image from the gallery, upload it to Firebase Storage and return 
  // the URL of the image in Firebase Storage.
  Future getImage(context) async {
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
        title: totalSum(context),
      ),
      body: ListBuilder(),     
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Select an image' ,
        child: FloatingActionButton(
          onPressed: () async {
            String imageURL = await getImage(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => NewScreen(imageURL: imageURL)));
          },
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }

}
