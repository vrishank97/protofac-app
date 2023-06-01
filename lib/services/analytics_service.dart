import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService extends ChangeNotifier {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  logVisit() async {
    _analytics.logAppOpen();
  }

  logScreenView(String screenName) async {
    _analytics.logScreenView(screenName: screenName);
  }
}
