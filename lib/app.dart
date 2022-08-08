import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'screens/list_screen.dart';

class App extends StatefulWidget {

  App({Key? key}) : super(key: key);
  
  // EXTRA CREDIT: Sentry Crash Report
  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    final sentryId =
        await Sentry.captureException(error, stackTrace: stackTrace);
  }

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {

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
      home: ListScreen()
    );
  }

}

