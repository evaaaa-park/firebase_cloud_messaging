import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initialize({required void Function(RemoteMessage) onData}) async {
    // Request notification permissions from the user (Android 13+ / iOS)
    await messaging.requestPermission(alert: true, badge: true, sound: true);

    // Handler 1: App is open and in the foreground
    // Fires immediately when a message arrives while the user is using the app
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      onData(message);
    });

    // Handler 2: App is in the background and user taps the notification
    // Fires when the user interacts with a notification to reopen the app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onData(message);
    });

    // Handler 3: App was fully terminated and launched via notification tap
    // Returns the message that caused the cold start, or null if opened normally
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      onData(initialMessage);
    }
  }

  // Returns the unique device token used to target this specific install
  Future<String?> getToken() {
    return messaging.getToken();
  }
}