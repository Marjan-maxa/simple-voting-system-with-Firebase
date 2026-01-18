import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_firebase/main.dart';
class NotificationService{
  static final FirebaseMessaging  _messaging=FirebaseMessaging.instance;

  static Future<void> initialize() async {

   await Firebase.initializeApp();

    NotificationSettings settings=await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true
    );
    print('Permission ${settings.authorizationStatus}'
    );

    String ?token=await _messaging.getToken();
    print('Device Token ${token}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      final context=navigatorKey.currentContext!;
    showDialog(context: context, builder: (_)=>AlertDialog(
      title: Text(message.notification!.title??""),
      content: Text(message.notification!.body??""),
    ));
    });

  }

Future<void> firebaseMassageBacroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
}
}