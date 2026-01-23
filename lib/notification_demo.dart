import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz ;

import 'local_notification.dart';
import 'package:timezone/timezone.dart' as tz;
class NotificationDemo extends StatefulWidget {
  const NotificationDemo({super.key});

  Future instantNotification() async {
    final details=NotificationDetails(
      android: AndroidNotificationDetails(
          'instant_channel',
          'instant',
        importance: Importance.max,
        priority: Priority.high
      )
    );

   await  flutterLocalNotificationsPlugin.show(
        0,
        'Notification setting',
        'Your notification is showed',
        details);
  }


  Future scheduleNotification() async {


    await  flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Office Schedule',
        'Office start after 10 sec',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(
          android: AndroidNotificationDetails('time_channel', 'time',
            importance: Importance.max,
            priority: Priority.high
          ),

        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: null);

  }

  Future dailyNotification() async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleTime = now.add(const Duration(seconds: 6));


    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,

        'Daily Schedule',
        'This notification will repeat daily',
        scheduleTime,
        NotificationDetails(
          android: AndroidNotificationDetails('Schedule_Channel', 'Schedule',
            importance: Importance.max,
            priority: Priority.high,
          )
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
     matchDateTimeComponents: DateTimeComponents.time
   );
    print('Daily notification scheduled at $scheduleTime');
  }

  @override
  State<NotificationDemo> createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Notification',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white
              ),
                onPressed: widget.instantNotification, child: Text('Instant')),
            const SizedBox(height: 15,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white
                ),
                onPressed: widget.scheduleNotification, child: Text('Time')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white
                ),
                onPressed: widget.dailyNotification, child: Text('Schedule'))
          ],
        ),
      ),
    );
  }
}
