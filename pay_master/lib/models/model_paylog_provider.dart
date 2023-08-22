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

  Future<void> InsertPaylog(
      String name, int payment, String time, String expdd) async {
    paylogsReference
        .add({"name": name, "payment": payment, "time": time, "expdd": expdd});
  }

  Future<void> DeletePaylog(String documentId) async {
    await paylogsReference.doc(documentId).delete();
  }

  Future<void> EditPaylog(String documentId, String name, int payment,
      String time, String expdd) async {
    await paylogsReference.doc(documentId).update(
        {"name": name, "payment": payment, "time": time, "expdd": expdd});
  }
}
