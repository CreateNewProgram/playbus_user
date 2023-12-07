import 'package:flutter/material.dart';
import 'package:playbus/login_page/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// FCM 토큰 얻기
  FirebaseMessaging.instance.getToken().then((token) {
    if (token != null) {
      print('FCM Token: $token');
      // TODO: 토큰을 사용하는 코드 추가
    } else {
      print('FCM 토큰을 얻을 수 없습니다.');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
