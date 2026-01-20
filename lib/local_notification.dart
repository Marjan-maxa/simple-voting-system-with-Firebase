import 'package:timezone/data/latest.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

 Future<void> iniNotification()async {
  tz.initializeTimeZones();

  AndroidInitializationSettings androidInitializationSettings=AndroidInitializationSettings('@mipmap/ic_launcher');
  DarwinInitializationSettings iosSetting=DarwinInitializationSettings();
  InitializationSettings initializationSettings=InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosSetting
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveBackgroundNotificationResponse: notificationTapBacround
  );
}
 @pragma('vm:entry-point')
void notificationTapBacround(NotificationResponse response){
   print('Notification Clicked');
}
 // 55:16 minutes after start