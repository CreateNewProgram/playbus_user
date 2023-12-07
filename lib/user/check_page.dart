import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/drawer.dart';

class CheckBoxListWidget extends StatefulWidget {
  @override
  _CheckBoxListWidgetState createState() => _CheckBoxListWidgetState();
}

class _CheckBoxListWidgetState extends State<CheckBoxListWidget> {
  List<String> itemList = [];
  List<String> itemCheckedList = [];

  @override
  void initState() {
    super.initState();
    loadDataFromFirestore(); // 앱 실행 시 Firestore에서 데이터 로드
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
        backgroundColor: Colors.grey[900],
        title: Text('인원 체크 현황'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Checkbox(
                value: itemCheckedList[index] == 'true',
                onChanged: null, // 체크박스 확인만 가능하도록 null로 설정
              ),
              title: Text(itemList[index]),
            );
          },
        ),
      ),
    );
  }

  Future<void> saveDataToFirestore() async {
    try {
      CollectionReference itemsCollection = FirebaseFirestore.instance.collection('check');
      // 기존 데이터 삭제
      await itemsCollection.doc('list').delete();
      // 새로운 데이터 추가
      await itemsCollection.doc('list').set({
        'items': itemList,
        'checkedItems': itemCheckedList,
      });
      print('Data saved to Firestore');
    } catch (e) {
      print('Error saving data to Firestore: $e');
    }
  }

  Future<void> loadDataFromFirestore() async {
    try {
      CollectionReference itemsCollection = FirebaseFirestore.instance.collection('check');
      DocumentSnapshot snapshot = await itemsCollection.doc('list').get();
      if (snapshot.exists) {
        // Firestore에서 데이터 로드
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          itemList = (data['items'] as List<dynamic>).cast<String>();
          itemCheckedList = (data['checkedItems'] as List<dynamic>).cast<String>();
        });
        print('Data loaded from Firestore');
      }
    } catch (e) {
      print('Error loading data from Firestore: $e');
    }
  }
}
