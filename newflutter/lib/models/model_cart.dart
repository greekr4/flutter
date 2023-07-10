import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newflutter/models/model_item.dart';

class CartProvider with ChangeNotifier {
  late CollectionReference cartReference;
  List<Item> cartItems = [];

  CartProvider({reference}) {
    cartReference = reference ?? FirebaseFirestore.instance.collection('carts');
  }


  Future<void> fetchCartItemOrCreate(String uid) async {
    if (uid == ''){
      return;
    }
    final cartSnapshot = await cartReference.doc(uid).get();
    if(cartSnapshot.exists){
      Map<String,dynamic> cartItemsMap = cartSnapshot.data() as Map<String, dynamic>;
      List<Item> temp = [];
      for (var item in cartItemsMap['items']) {
        temp.add(Item.fromMap(item));
      }
      cartItems = temp;
      notifyListeners();
    }else{
      await cartReference.doc(uid).set({'items' : []});
      notifyListeners();
    }
  }


  Future<void> addCartItem(String uid, Item item) async {
    print('debug $uid');
    cartItems.add(item);
    Map<String, dynamic> cartItemsMap = {
      'items': cartItems.map( (item) {
        return item.toSnapshot();
      }).toList()
    };
    await cartReference.doc(uid).set(cartItemsMap);
    notifyListeners();
  }


  Future<void> removeCartItem(String uid, Item item) async {
    cartItems.removeWhere((element) => element.id == item.id);
    Map<String, dynamic> cartItemsMap = {
      'items' : cartItems.map((item) {
        return item.toSnapshot();
      }).toList()
    };
    await cartReference.doc(uid).set(cartItemsMap);
    notifyListeners();
  }

  bool isCartItemIn(Item item){
    return cartItems.any((element) => element.id == item.id);
  }


}