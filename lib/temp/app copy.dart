import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/temp/loading_screen.dart';
import '../screens/new_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/list_screen.dart';

class App extends StatefulWidget {

  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  late String imageURL;
  late DocumentSnapshot post;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      routes: getRoutes(),
    );
  }
  Map<String, WidgetBuilder> getRoutes() {

    return {
      '/': (context) => ListScreen(),
      'new': (context) => NewScreen(imageURL: imageURL,),
      'view': (context) => DetailScreen(post: post,),
    };
  }
}

