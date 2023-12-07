import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/drawer.dart';

class mainPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
        title: const Text('PLAY BUS'),
        centerTitle: true,
        backgroundColor: Colors.grey[900], // AppBar 배경색 변경
        leading: IconButton(
          onPressed: signUserOut,
          icon: Icon(Icons.logout),
        ),
      ),
      body: Container(
        color: Colors.grey[300], // 배경화면 색상 변경
      ),
    );
  }
}
