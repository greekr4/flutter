import 'package:firebase_core/firebase_core.dart';
import 'package:newflutter/models/model_auth.dart';
import 'package:newflutter/models/model_cart.dart';
import 'package:newflutter/models/model_item_provider.dart';
import 'package:newflutter/models/model_query.dart';
import 'package:newflutter/screen/screen_detail.dart';
import 'package:newflutter/screen/screen_search.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:newflutter/firebase_options.dart';
import 'package:newflutter/screen/screen_Login.dart';
import 'package:newflutter/screen/screen_index.dart';
import 'package:newflutter/screen/screen_register.dart';
import 'package:newflutter/screen/screen_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
          ChangeNotifierProvider(create: (_) => ItemProvider()),
          ChangeNotifierProvider(create: (_) => QueryProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
      child: MaterialApp(
        title: 'Shopping mall',
        routes: {
          '/index': (context) => IndexScreen(),
          '/login': (context) => LoginScreen(),
          '/splash': (context) => SplashScreen(),
          '/register' : (context) => RegisterScreen(),
          '/detail' : (context) => DetailScreen(),
          '/search' : (context) => SearchScreen(),

        },
        initialRoute: '/splash',
      ),
      );
  }
}

