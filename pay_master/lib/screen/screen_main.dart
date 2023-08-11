import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pay_master/models/model_paylog_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

TimeOfDay SinitialTime = TimeOfDay(hour: 8, minute: 00);
TimeOfDay EinitialTime = TimeOfDay.now();
String insertexpdd = "";
String insert_name = "";
String insert_stime = "";
String insert_etime = "";
String insert_time = "";
int insert_payment = 0;

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
              insertexpdd = DateFormat('yyyy년 MM월 dd일').format(selectedDay);
            });
          },
          selectedDayPredicate: (DateTime day) {
            // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
            return isSameDay(selectedDay, day);
          },
        ),
        // Padding(
        //     padding: EdgeInsets.all(10),
        //     child: Divider(
        //       thickness: 1,
        //       color: Colors.indigo,
        //     )),
        ListTile(
            trailing: IconButton(
          icon: Icon(
            Icons.add_box_rounded,
            size: 40,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            insert_name = "";
            insert_payment = 0;
            insert_time = "";
            insert_stime = "";
            insert_etime = "";
            // paylogProvider.InsertPaylog();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: Text('추가하기'),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Text(insertexpdd),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: '이름',
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.blueAccent),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              onChanged: (value) {
                                insert_name = value;
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                          child: StimetextChanger(),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                          child: EtimetextChanger(),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter
                                    .digitsOnly // 숫자만 입력할 수 있도록 제한합니다.
                              ],
                              decoration: InputDecoration(
                                labelText: '금액',
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.blueAccent),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              onChanged: (value) {
                                insert_payment = int.parse(value);
                              },
                            )),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        String insert_expdd =
                            DateFormat('yyyyMMdd').format(selectedDay);
                        String insert_time =
                            insert_stime + " ~ " + insert_etime;
                        print('날짜 : $insert_expdd');
                        print('이름 : $insert_name');
                        print('시간 : $insert_time');
                        print('금액 : $insert_payment');

                        // if (insert_expdd != "") {
                        //   Navigator.of(context).pop();
                        //   return;
                        // }
                        // if (insert_name != "") {
                        //   Navigator.of(context).pop();
                        //   return;
                        // }
                        // if (insert_stime != "") {
                        //   Navigator.of(context).pop();
                        //   return;
                        // }
                        // if (insert_etime != "") {
                        //   Navigator.of(context).pop();
                        //   return;
                        // }
                        // if (insert_payment == 0) {
                        //   Navigator.of(context).pop();
                        //   return;
                        // }

                        paylogProvider.InsertPaylog(insert_name, insert_payment,
                            insert_time, insert_expdd);
                        print('성공');
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('submit'),
                    ),
                  ],
                );
              },
            );
          },
        )),
        Expanded(
          child: FutureBuilder(
            future: _fetchPaylogsForSelectedDay(paylogProvider),
            builder: (context, snapshot) {
              //
              // print(paylogProvider.paylogs);
              // print(paylogProvider.paylogs[0].id);
              // print(expdd);
              if (paylogProvider.paylogs.length == 0) {
                return Center(
                  child: Text('데이터 없음'),
                );
              } else {
                return ListView.builder(
                  itemCount: paylogProvider.paylogs.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The start action pane is the one at the left or the top side.

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            onPressed: (context) {},
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: '수정',
                          ),
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: '삭제',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: ListTile(
                        leading: Icon(
                          Icons.face,
                          size: 45,
                        ),
                        iconColor: Colors.blueAccent,
                        title: Text(paylogProvider.paylogs[index].name),
                        subtitle: Text('시간 : ' +
                            paylogProvider.paylogs[index].time +
                            '\n금액 : ' +
                            NumberFormat.currency(locale: 'ko_KR', symbol: '')
                                .format(paylogProvider.paylogs[index].payment)
                                .toString()),
                      ),
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

class StimetextChanger extends StatefulWidget {
  @override
  StimeTextState createState() => StimeTextState();
}

class StimeTextState extends State<StimetextChanger> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          //initialTime: TimeOfDay(hour: 8, minute: 0),
          initialTime: SinitialTime,
        );
        if (timeOfDay != null) {
          setState(() {
            SinitialTime = timeOfDay;
            String formatStime = SinitialTime.hour.toString().padLeft(2, '0') +
                ":" +
                SinitialTime.minute.toString().padLeft(2, '0');
            _controller.text = formatStime;
            insert_stime = _controller.text;
          });
        }
      },
      child: AbsorbPointer(
        absorbing: true,
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: '시작 시간',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.blueAccent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}

class EtimetextChanger extends StatefulWidget {
  @override
  EtimeTextState createState() => EtimeTextState();
}

class EtimeTextState extends State<EtimetextChanger> {
  TextEditingController _Econtroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          //initialTime: TimeOfDay(hour: 8, minute: 0),
          initialTime: EinitialTime,
        );
        if (timeOfDay != null) {
          setState(() {
            EinitialTime = timeOfDay;
            String formatEtime = EinitialTime.hour.toString().padLeft(2, '0') +
                ":" +
                EinitialTime.minute.toString().padLeft(2, '0');
            _Econtroller.text = formatEtime;
            insert_etime = _Econtroller.text;
          });
        }
      },
      child: AbsorbPointer(
        absorbing: true,
        child: TextField(
          controller: _Econtroller,
          decoration: InputDecoration(
            labelText: '시작 시간',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.blueAccent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}
