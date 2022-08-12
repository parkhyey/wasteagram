import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'screens/list_screen.dart';
import 'screens/new_screen.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();

}

class AppState extends State<App> {
  
  // EXTRA CREDIT: Firebase Analytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = 
    FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    // throw StateError('error demo');
    return MaterialApp(
        title: 'Wasteagram',
        theme: ThemeData.dark(),
        routes: {
          '/': (context) => ListScreen(observer: observer),
          'new': (context) => NewScreen(observer: observer),
        },
        navigatorObservers: <NavigatorObserver>[observer],
    );
  }

}