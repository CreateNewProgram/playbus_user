import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/drawer.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _scheduleCollection = 'TimetableMgScreen'; // Collection name changed to 'TimetableMgScreen'
  Map<String, String> _schedule = {};

  @override
  void initState() {
    super.initState();
    _loadSchedule();
  }

  void _loadSchedule() async {
    final documentSnapshot = await _firestore.collection(_scheduleCollection).doc('timetable').get();
    if (documentSnapshot.exists) {
      setState(() {
        _schedule = Map<String, String>.from(documentSnapshot.data()!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
        title: Text('수업 시간표'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[500]),
              children: [
                SizedBox.shrink(),
                for (var day in [' 월 ', ' 화 ', ' 수 ', ' 목 ', ' 금 '])
                  Center(child: Text(day)),
              ],
            ),
            for (var i = 8; i <= 17; i++) // Changed loop range to 8 to 17
              TableRow(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.grey[300],
                    child: Center(child: Text('${i.toString().padLeft(2, '0')}:00')), // Display formatted time
                  ),
                  for (var day in ['월', '화', '수', '목', '금'])
                    Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(_schedule['$day $i'] ?? ''),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
