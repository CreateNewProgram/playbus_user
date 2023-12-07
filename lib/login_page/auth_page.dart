import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playbus/user/main_screen.dart';
import 'login_or_register_page.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //uer is logged in
          if(snapshot.hasData){
            return mainPage();
          }
          //user is NOT logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
