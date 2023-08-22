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

  String expdd = DateFormat('yyyyMMdd').format(DateTime.now());
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
            setState(() {
              this.selectedDay = selectedDay;
              this.focusedDay = focusedDay;
              this.expdd = DateFormat('yyyyMMdd').format(selectedDay);
              insertexpdd = DateFormat('yyyy년 MM월 dd일').format(selectedDay);
            });
          },
          selectedDayPredicate: (DateTime day) {
            return isSameDay(selectedDay, day);
          },
        ),
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
                                FilteringTextInputFormatter.digitsOnly // 숫자만 입력
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
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('취소')),
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

                        paylogProvider.InsertPaylog(insert_name, insert_payment,
                            insert_time, insert_expdd);
                        print('성공');
                        Navigator.of(context).pop(); // Close the dialog
                        paylogProvider.SelectPaylogs(expdd); //리로드
                      },
                      child: Text('추가'),
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
              if (paylogProvider.paylogs.length == 0) {
                return Center(
                  child: Text('데이터 없음'),
                );
              } else {
                return ListView.builder(
                  itemCount: paylogProvider.paylogs.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              TextEditingController _editNameCtrl =
                                  TextEditingController(
                                      text: paylogProvider.paylogs[index].name);
                              TextEditingController _editPaymentCtrl =
                                  TextEditingController(
                                      text: paylogProvider
                                          .paylogs[index].payment
                                          .toString());

                              List times = paylogProvider.paylogs[index].time
                                  .split(" ~ ");

                              TextEditingController _editStimeCtrl =
                                  TextEditingController(text: times[0]);
                              TextEditingController _editEtimeCtrl =
                                  TextEditingController(text: times[1]);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text('수정하기'),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(insertexpdd),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20.0, 0.0, 20.0, 10.0),
                                              child: TextField(
                                                controller: _editNameCtrl,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: '이름',
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colors.redAccent),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colors.blueAccent),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  insert_name = value;
                                                },
                                              )),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20.0, 0.0, 20.0, 10.0),
                                            child: StimetextChanger_Edit(
                                                controller: _editStimeCtrl),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20.0, 0.0, 20.0, 10.0),
                                            child: EtimetextChanger_Edit(
                                              controller: _editEtimeCtrl,
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20.0, 0.0, 20.0, 10.0),
                                              child: TextField(
                                                controller: _editPaymentCtrl,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly // 숫자만 입력
                                                ],
                                                decoration: InputDecoration(
                                                  labelText: '금액',
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colors.redAccent),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colors.blueAccent),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  insert_payment =
                                                      int.parse(value);
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: Text('취소')),
                                      TextButton(
                                        onPressed: () {
                                          String insert_expdd =
                                              DateFormat('yyyyMMdd')
                                                  .format(selectedDay);
                                          String insert_time = insert_stime +
                                              " ~ " +
                                              insert_etime;
                                          print('날짜 : $insert_expdd');
                                          print('이름 : $insert_name');
                                          print('시간 : $insert_time');
                                          print('금액 : $insert_payment');
                                          paylogProvider.EditPaylog(
                                              paylogProvider.paylogs[index].id,
                                              insert_name,
                                              insert_payment,
                                              insert_time,
                                              insert_expdd);
                                          print('성공');
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          paylogProvider.SelectPaylogs(
                                              expdd); //리로드
                                        },
                                        child: Text('수정'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: '수정',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              paylogProvider.DeletePaylog(
                                  paylogProvider.paylogs[index].id); //삭제
                              paylogProvider.SelectPaylogs(expdd); //리로드
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: '삭제',
                          ),
                        ],
                      ),
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
            labelText: '종료 시간',
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

class StimetextChanger_Edit extends StatefulWidget {
  final TextEditingController controller;
  StimetextChanger_Edit({required this.controller, Key? key}) : super(key: key);

  @override
  StimeTextState_Edit createState() => StimeTextState_Edit();
}

class StimeTextState_Edit extends State<StimetextChanger_Edit> {
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
            widget.controller.text = formatStime;
            insert_stime = widget.controller.text;
          });
        }
      },
      child: AbsorbPointer(
        absorbing: true,
        child: TextField(
          controller: widget.controller,
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

class EtimetextChanger_Edit extends StatefulWidget {
  final TextEditingController
      controller; // Add a controller parameter to the constructor
  EtimetextChanger_Edit({required this.controller, Key? key}) : super(key: key);

  @override
  EtimeTextState_Edit createState() => EtimeTextState_Edit();
}

class EtimeTextState_Edit extends State<EtimetextChanger_Edit> {
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
            widget.controller.text = formatEtime;
            insert_etime = widget.controller.text;
          });
        }
      },
      child: AbsorbPointer(
        absorbing: true,
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: '종료 시간',
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
