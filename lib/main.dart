import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'auth/sentry_dsn.dart';

String DSN_URL = '$MY_DSN_URL';

Future<void> main() async {
  await SentryFlutter.init(
    (options) => options.dsn = DSN_URL,
    appRunner: () => runApp(App()),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight]);

  await Firebase.initializeApp();
  runApp(App());
}
