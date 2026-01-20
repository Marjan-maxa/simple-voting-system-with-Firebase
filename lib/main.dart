import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_firebase/notification_service.dart';

import 'firebase_options.dart';
import 'local_notification.dart';
import 'myapp.dart';

 final GlobalKey<NavigatorState> navigatorKey=GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await NotificationService.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await iniNotification();



  runApp(const Myapp());
}

