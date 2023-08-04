import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pay_master/firebase_options.dart';
import 'package:pay_master/models/model_auth.dart';
import 'package:pay_master/models/model_register.dart';
import 'package:pay_master/screen/screen_login.dart';
import 'package:pay_master/screen/screen_main.dart';
import 'package:pay_master/screen/screen_regist.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
      ],
      child: MaterialApp(
        title: '인건비관리',
        routes: {
          '/index': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/main': (context) => MainScreen(),
          // '/splash': (context) => SplashScreen(),
          // '/register': (context) => RegisterScreen(),
        },
        initialRoute: '/index',
      ),
    );
  }
}
