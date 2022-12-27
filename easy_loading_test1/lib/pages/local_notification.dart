import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
////timezone 이용 하고 일정 시간 후 알람 울리기 위한 부분 
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
///여기

class LocalNotification {

  LocalNotification._();
  
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
 
  static initialize() async {
    ///timezone init
    tz.initializeTimeZones();
    final timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName)); 
    
    
    //////
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('mipmap/ic_launcher');

  
    DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  
  }
  static void requestPermission(){
    _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true
    );
  }
  // time zone
  // 타임존 셋팅 필요
 

  static Future<void> zonedScheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails("channel id", "channel name",
            channelDescription: "channel description",
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);
    
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(
        badgeNumber: 1,
      ),
    );
    final now = tz.TZDateTime.now(tz.local);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'alarmTitle',
      'alarmDescription',
      tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute + 1,
      ),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  //이 함수가  보여주는 부분
  //단순 알람
 
  static Future<void> sampleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails("channel id", "channel name",
            channelDescription: "channel description",
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);
    
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(
        badgeNumber: 1,
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
        0, "plain title", "plain body", platformChannelSpecifics,
        payload: "item x");
  }//sampleNotification
  
}//class