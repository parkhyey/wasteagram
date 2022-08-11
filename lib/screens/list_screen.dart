import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/waste_post.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import '../widgets/list_builder.dart';
import '../widgets/total_sum.dart';

class ListScreen extends StatefulWidget {
  FirebaseStorage storage = FirebaseStorage.instance;
  ListScreen({Key? key}) : super(key: key);

  @override
  State createState() => _ListScreenState();
  
}

class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TotalSum(),
      ),
      body: ListBuilder(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Add new post',
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('new');},
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }

  // void _sendCurrentTabToAnalytics() {
  //   observer.analytics.setCurrentScreen(screenName: 'List Screen');
  // }
}
