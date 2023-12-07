import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/drawer.dart';

class BusTimeScreen extends StatefulWidget {
  const BusTimeScreen({Key? key}) : super(key: key);

  @override
  _BusTimeScreenState createState() => _BusTimeScreenState();
}

class _BusTimeScreenState extends State<BusTimeScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _timetableCollection = 'BusTimeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
        title: const Text('버스 시간표'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        color: Colors.grey[300],
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection(_timetableCollection).orderBy('timestamp').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['content']),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
