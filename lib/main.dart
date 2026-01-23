import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_firebase/notification_service.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'firebase_options.dart';
import 'local_notification.dart';
import 'myapp.dart';

 final GlobalKey<NavigatorState> navigatorKey=GlobalKey<NavigatorState>();
 main() async{

  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  const AndroidNotificationChannel scheduleChannel =
  AndroidNotificationChannel(
   'Schedule_Channel',
   'Schedule',
   importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(scheduleChannel);

  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
 await NotificationService.initialize();


  await iniNotification();



  runApp(const Myapp());
}

