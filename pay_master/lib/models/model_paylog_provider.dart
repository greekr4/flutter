import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pay_master/models/model_paylog.dart';

class PaylogProvider with ChangeNotifier {
  late CollectionReference paylogsReference;
  List<Paylog> paylogs = [];
  List<Paylog> serachDayPaylogs = [];

  PaylogProvider({reference}) {
    paylogsReference =
        reference ?? FirebaseFirestore.instance.collection('paylog');
  }

  Future<void> fetchPaylogs() async {
    paylogs = await paylogsReference.get().then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot document) {
        return Paylog.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }

  Future<void> SelectPaylogs(String expdd) async {
    // paylogs = [];

    // // QuerySnapshot querySnapshot =
    // //     await paylogsReference.where('expdd', isEqualTo: expdd).get();

    // // paylogs = querySnapshot.docs.map((DocumentSnapshot document) {
    // //   return Paylog.fromSnapshot(document);
    // // }).toList();

    paylogs = await paylogsReference
        .where('expdd', isEqualTo: expdd)
        .get()
        .then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot document) {
        return Paylog.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }

  Future<void> InsertPaylog() async {
    paylogsReference.add({
      "name": "zz",
      "payment": 1000,
      "time": "15:00~16:00",
      "expdd": "20230811"
    });
  }
}
