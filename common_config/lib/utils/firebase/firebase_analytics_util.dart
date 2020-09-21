import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class FirebaseAnalyticsA {
  FirebaseAnalyticsA() {
    analytics = FirebaseAnalytics();
    observer = FirebaseAnalyticsObserver(analytics: analytics);
  }

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  static Future<void> sendAnalyticsEvent(String event_name, Map map) async {
    if (analytics == null) {
      analytics = FirebaseAnalytics();
      observer = FirebaseAnalyticsObserver(analytics: analytics);
    }
    await analytics.logEvent(
      name: event_name,
      parameters: map,
    );
  }
}
