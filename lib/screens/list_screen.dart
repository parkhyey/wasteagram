import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/list_builder.dart';
import '../widgets/total_sum.dart';

class ListScreen extends StatefulWidget {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAnalyticsObserver? observer;
  ListScreen({Key? key, required this.observer}) : super(key: key);

  @override
  State createState() => _ListScreenState();
  
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
            sendCurrentTabToAnalytics();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TotalSum(),
      ),
      body: const ListBuilder(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Create new post',
        child: FloatingActionButton(
          onPressed: () {
            sendCurrentTabToAnalytics();
            Navigator.of(context).pushNamed('new');},
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }
  void sendCurrentTabToAnalytics() {
    widget.observer!.analytics.setCurrentScreen(screenName: 'List Screen');
  }

}
