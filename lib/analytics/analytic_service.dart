import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
 final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future logScreens({required String? name}) async {
  await _analytics.setCurrentScreen(screenName: name);
 }
}