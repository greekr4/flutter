import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_master/models/model_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getEmail(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 로딩 중인 경우 로딩 스피너 표시
        } else if (snapshot.hasError) {
          return Text('에러 발생'); // 에러가 있는 경우 에러 메시지 표시
        } else {
          String email = snapshot.data ?? ''; // 이메일 값을 가져옴
          return Scaffold(
            appBar: AppBar(
              title: Text('메인'),
              centerTitle: true,
              actions: [
                Icon(Icons.search),
                Padding(padding: EdgeInsets.all(5)),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => {},
                ),
                Padding(padding: EdgeInsets.all(5)),
              ],
            ),
            body: Center(child: Text('메인화면임')),
            drawer: Drawer(
              child: ListView(children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/image/icon.png'),
                  ),
                  accountName: Text('관리자'),
                  accountEmail: Text(email), // 이메일 값 사용
                  decoration: BoxDecoration(
                      color: Colors.blueAccent[200],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0))),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  iconColor: Colors.blueAccent,
                  focusColor: Colors.blueAccent,
                  title: Text('홈'),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.abc),
                  iconColor: Colors.blueAccent,
                  focusColor: Colors.blueAccent,
                  title: Text('메뉴1'),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.abc),
                  iconColor: Colors.blueAccent,
                  focusColor: Colors.blueAccent,
                  title: Text('메뉴2'),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () => {},
                )
              ]),
            ),
          );
        }
      },
    );
  }
}
