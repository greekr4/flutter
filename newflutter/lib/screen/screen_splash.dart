import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newflutter/models/model_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}


class _SplashScreenState extends State<SplashScreen>{


    Future<bool> checkLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final cartProvider = Provider.of<CartProvider>(context,listen: false);
      bool isLogin = prefs.getBool('isLogin') ?? false;
      String uid = prefs.getString('uid') ?? '';
      cartProvider.fetchCartItemOrCreate(uid);
    return isLogin;
    }

    void moveScreen() async {
      await checkLogin().then((isLogin){
        if(isLogin){
          Navigator.of(context).pushReplacementNamed('/index');
        }else{
          Navigator.of(context).pushReplacementNamed('/login');
        }
      });
    }




    @override
  void initState() {
      super.initState();
      Timer(Duration(microseconds: 2000), (){
        moveScreen();
      });
    }

    @override
  Widget build(BuildContext context) {
      return const Scaffold(
        appBar: null,
      body: Center(
          child: Text("Splash screen"),

          ),
      );

    }



}