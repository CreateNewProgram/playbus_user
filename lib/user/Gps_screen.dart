import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/drawer.dart';

class AllowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
        title: Text('버스 위치 정보'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationInfoScreen()),
              );
            },
            style: ElevatedButton.styleFrom(primary: Colors.black),
            child: Text('버스 위치 보기'),
          ),
        ),
      ),
    );
  }
}

class LocationInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('실시간 버스 정보'),
        backgroundColor: Colors.grey[700],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bus_locations')
            .doc('current_location')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('저장된 위치 정보가 없습니다.'));
          }

          double latitude = snapshot.data!['latitude'];
          double longitude = snapshot.data!['longitude'];

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 18.9, // 시작 줌 크기를 조정합니다.
            ),
            markers: Set<Marker>.from([
              Marker(
                markerId: MarkerId('location'),
                position: LatLng(latitude, longitude),
              ),
            ]),
          );
        },
      ),
    );
  }
}
