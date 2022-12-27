import 'package:easy_loading_test1/pages/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'pages/easyloadingtest.dart';

void main() {
  runApp(const MyApp());
  
  LocalNotification.initialize();//알림 초기화
  LocalNotification.requestPermission();//알림 권환 주
  configLoading();
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:  const EasyLoadingTest(),
      builder: EasyLoading.init(),
     
     
            
    );
  }
}

