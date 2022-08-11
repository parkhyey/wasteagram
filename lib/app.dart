import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'screens/list_screen.dart';
import 'screens/new_screen.dart';

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
  // bool _initialized = false;
  // bool _error = false;

  // @override
  // void initState() {
  //   super.initState();
  //   initFirebase();
  // }

  // void initFirebase() async {
  //   try {
  //     await Firebase.initializeApp();
  //     setState(() {
  //       _initialized = true;
  //     });
  //   } catch(e) {
  //     setState(() {
  //       _error = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wasteagram',
        theme: ThemeData.dark(),
        routes: {
          '/': (context) => ListScreen(),
          'new': (context) => NewScreen(),
        }
    );
  }
}