import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../models/food_waste_post_DTO.dart';
import '../widgets/bottom_appbar.dart';
import '../widgets/new_post_form.dart';
import 'list_screen.dart';
import '../app.dart';

class NewScreen extends StatefulWidget {
  String imageURL;
  
  FirebaseStorage storage = FirebaseStorage.instance;
  NewScreen({Key? key, required this.imageURL}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final formkey = GlobalKey<FormState>();
  FoodWastePostDTO newPost = FoodWastePostDTO();
  LocationData? geoData;

  Future<List<Map<String, dynamic>>> loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await widget.storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference> (allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      files.add({
        "imageURL": fileUrl,
      });
    });
    return files;
  }
  
  @override
  void initState() {
    super.initState();
    _getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: const Text('New Post')),
      body: FutureBuilder(
        future: loadImages(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                var loadImage = Image.network(widget.imageURL);
                return Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(height: 240, child: loadImage),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: newPostForm(context, newPost),
                      ),
                    ],
                  ),
                );
              },
            );
          }
      ),
    bottomNavigationBar: 
      bottomAppBar(context, formkey, newPost, geoData, widget.imageURL),
    );
  }

  // get permissions and location from https://pub.dev/packages/location
  void _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    var geo = Location();

    try {
      _serviceEnabled = await geo.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await geo.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
    _permissionGranted = await geo.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await geo.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                  title: const Text('Location Services must be enabled.'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => ListScreen()));
                        },
                        child: const Text('Ok'))
                  ]
                );
            }
          );
        return;
      }
    }
    geoData = await geo.getLocation();
    } on PlatformException catch (e) {
    print('Error: ${e.toString()}, code: ${e.code}');
    geoData = null;
    }
  }


  // void _openGallery() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   image = XFile(pickedFile!.path);
  //   imageSelected = true;
  //   setState(() {});
  // }

  // void _openCamera() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
  //   image = XFile(pickedFile!.path);
  //   imageSelected = true;
  //   setState(() {});
  // }


}
