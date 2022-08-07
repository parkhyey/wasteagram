import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../models/food_waste_post.dart';
import '../models/food_waste_post_DTO.dart';
import 'waste_list_screen.dart';

class NewWasteScreen extends StatefulWidget {
  String imageURL;
  
  FirebaseStorage storage = FirebaseStorage.instance;
  NewWasteScreen({Key? key, required this.imageURL}) : super(key: key);

  @override
  State<NewWasteScreen> createState() => _NewWasteScreenState();
}

class _NewWasteScreenState extends State<NewWasteScreen> {
  final _formkey = GlobalKey<FormState>();
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
          // if (!snapshot.hasData || snapshot.data!.isEmpty) {
          if (newPost.quantity == null) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                var loadImage = Image.network(widget.imageURL);
                return Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(height: 240, child: loadImage),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Semantics(
                          textField: true,
                          focusable: true,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            autofocus: true,
                            inputFormatters: [NumericKeypad(),],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Number of Wasted Items',
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: 25.0, height: 2.0),
                            onSaved: (value) {
                              newPost.quantity = int.tryParse(value!);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the number of items.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    bottomNavigationBar: bottomAppBar(),
    );
  }

  Widget bottomAppBar() {
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
              if (_formkey.currentState!.validate()) {
                _formkey.currentState!.save();
                newPost.latitude = geoData!.latitude;
                newPost.longitude = geoData!.longitude;
                newPost.imageURL = widget.imageURL;
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
                              builder: (context) => WasteListScreen()));
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

}

class NumericKeypad extends TextInputFormatter {
  static final _reg = RegExp(r'^\d+$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return _reg.hasMatch(newValue.text) ? newValue : oldValue;
  }
}
