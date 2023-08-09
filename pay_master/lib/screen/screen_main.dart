import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pay_master/models/model_paylog_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

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
            body: Center(child: TableCalendarScreen()),
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

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({Key? key}) : super(key: key);

  @override
  State<TableCalendarScreen> createState() => _ekffur();
}

class _ekffur extends State<TableCalendarScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  String expdd = "";
  String lastexpdd = "";

  @override
  Widget build(BuildContext context) {
    final paylogProvider = Provider.of<PaylogProvider>(context);
    return Column(
      children: [
        TableCalendar(
          locale: 'ko-KR',
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: selectedDay,
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              headerMargin:
                  EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 10),
              titleCentered: true,
              titleTextStyle: const TextStyle(fontSize: 25.0)),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, dynamic event) {
              if (event.isNotEmpty) {
                return Container(
                  width: 35,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      shape: BoxShape.circle),
                );
              }
            },
          ),
          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
            // 선택된 날짜의 상태를 갱신합니다.
            setState(() {
              this.selectedDay = selectedDay;
              this.focusedDay = focusedDay;
              this.expdd = DateFormat('yyyyMMdd').format(selectedDay);
            });
          },
          selectedDayPredicate: (DateTime day) {
            // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
            return isSameDay(selectedDay, day);
          },
        ),
        Expanded(
          child: FutureBuilder(
            future: _fetchPaylogsForSelectedDay(paylogProvider),
            builder: (context, snapshot) {
              //
              // print(paylogProvider.paylogs);
              print(expdd);
              if (paylogProvider.paylogs.length == 0) {
                return Center(
                  child: Text('데이터 없음'),
                );
              } else {
                return ListView.builder(
                  itemCount: paylogProvider.paylogs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.money_sharp),
                      iconColor: Colors.blueAccent,
                      trailing: Icon(Icons.delete),
                      title: Text(paylogProvider.paylogs[index].name),
                      subtitle: Text('시간 : ' +
                          paylogProvider.paylogs[index].time +
                          '\n금액 : ' +
                          NumberFormat.currency(locale: 'ko_KR', symbol: '')
                              .format(paylogProvider.paylogs[index].payment)
                              .toString()),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }

  Future<void> _fetchPaylogsForSelectedDay(
      PaylogProvider paylogProvider) async {
    if (expdd == lastexpdd) {
    } else {
      String expdd = DateFormat('yyyyMMdd').format(selectedDay);
      await paylogProvider.SelectPaylogs(expdd);
      lastexpdd = expdd;
    }
  }
}
