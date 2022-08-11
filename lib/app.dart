import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'screens/list_screen.dart';

class App extends StatefulWidget {

  App({Key? key}) : super(key: key);
  
  // EXTRA CREDIT: Sentry Crash Report
  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    final sentryId =
        await Sentry.captureException(error, stackTrace: stackTrace);
  }

  // adding Firebase Analytics---------------------
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer = 
  //   FirebaseAnalyticsObserver(analytics: analytics);

  // Future<void> _sendAnalyticsEvent() async {
  //   // Not supported on web
  //   await FirebaseAnalytics.instance.setDefaultEventParameters({
  //       "version": "1.2.3"
  //     });
  // }
  // until here------------------------------------

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {

// @override
// void initState() {
//   App.observer;
//   super.initState();
// }
  @override
  Widget build(BuildContext context) {
    // throw StateError('error demo');
    // throw UnimplementedError('error demo');
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      // adding Firebase Analytics---------------------
      // navigatorObservers: <NavigatorObserver>[App.observer],
      // until here------------------------------------
      home: ListScreen()
    );
  }

}
