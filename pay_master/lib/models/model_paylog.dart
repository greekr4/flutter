import 'package:cloud_firestore/cloud_firestore.dart';

class Paylog {
  late String id;
  late String expdd;
  late String name;
  late String time;
  late int payment;
  late String etc;

  Paylog({
    required this.id,
    required this.expdd,
    required this.name,
    required this.time,
    required this.payment,
    required this.etc,
  });

  Paylog.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;
    expdd = data['expdd'];
    name = data['name'];
    time = data['time'];
    payment = data['payment'];
    etc = data['etc'];
  }

  // Paylog.fromMap(Map<String, dynamic> data) {
  //   id = data['id'];
  //   expdd = data['expdd'];
  //   name = data['name'];
  //   time = data['time'];
  //   payment = data['payment'];
  // }

  // Map<String, dynamic> toSnapshot() {
  //   return {
  //     'id': id,
  //     'expdd': expdd,
  //     'name': name,
  //     'time': time,
  //     'payment': payment,
  //   };
  // }
}
