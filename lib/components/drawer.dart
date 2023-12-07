import 'package:flutter/material.dart';
import 'package:playbus/user/main_screen.dart';
import '../user/Gps_screen.dart';
import '../user/board_screen.dart';
import '../user/bustime_screen.dart';
import '../user/check_page.dart';
import '../user/notice_screen.dart';
import '../user/profile_screen.dart';
import '../user/timetable_screen.dart';
import 'my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                ),
                MyListTile(
                  icon: Icons.home,
                  text: '메인화면',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => mainPage()),
                    );
                  },
                ),
                MyListTile(
                  icon: Icons.article_outlined,
                  text: '소통방',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => boardPage()),
                    );
                  },
                ),
                MyListTile(
                  icon: Icons.announcement,
                  text: '공지사항',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NoticeScreen()),
                    );
                  },
                ),
                MyListTile(
                  icon: Icons.event,
                  text: '수업 시간표',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimetableScreen()),
                    );
                  },
                ),
                MyListTile(
                  icon: Icons.departure_board,
                  text: '버스 시간표',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BusTimeScreen()),
                    );
                  },
                ),
                MyListTile(
                  icon: Icons.directions_bus,
                  text: '현재 버스 위치',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllowScreen()),
                    );
                  },
                ),
                MyListTile(
                  icon: Icons.person,
                  text: '인원 체크 현황',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckBoxListWidget()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
