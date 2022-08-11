import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'auth/sentry_dsn.dart';
import 'app.dart';

String DSN_URL = '$MY_DSN_URL';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight]);

  await Firebase.initializeApp();
  await SentryFlutter.init(
    (options) => options.dsn = DSN_URL,
    appRunner: () => runApp(App()),
  );
  
}
