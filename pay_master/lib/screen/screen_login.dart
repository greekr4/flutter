import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pay_master/models/model_auth.dart';
import 'package:pay_master/models/model_login.dart';
import 'package:pay_master/models/model_register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  Future<void> isLogin(BuildContext context) async {
    final secureStorage = FlutterSecureStorage();
    final email = await secureStorage.read(key: "email");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (email != null) {
      print('자동로그인상태');
      prefs.setString('email', email);
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      print('자동로그인아님');
    }
  }

  @override
  Widget build(BuildContext context) {
    isLogin(context);
    return ChangeNotifierProvider(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('인건비관리'),
        ),
        body: Column(children: [
          EmailInput(),
          PasswordInput(),
          LoginButton(),
          Padding(
              padding: EdgeInsets.all(10),
              child: Divider(
                thickness: 1,
                color: Colors.indigo,
              )),
          GoRegister(),
        ]),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
        onChanged: (email) {
          login.setEmail(email);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(labelText: '이메일', helperText: ''),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
        onChanged: (password) {
          login.setPassword(password);
        },
        obscureText: true,
        decoration: InputDecoration(labelText: '비밀번호', helperText: ''),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient =
        Provider.of<FirebaseAuthProvider>(context, listen: false);
    final login = Provider.of<LoginModel>(context, listen: false);
    final secureStorage = FlutterSecureStorage(); // SecureStorage 인스턴스 생성
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          //로그인
          Gologin(
              authClient, secureStorage, login.email, login.password, context);
        },
        child: Text('로그인'),
      ),
    );
  }
}

class GoRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/register');
        },
        child: Text(
          '관리자 계정 생성',
        ));
  }
}

Future<void> Gologin(
    authClient, secureStorage, email, password, BuildContext context) async {
  await authClient.loginWithEmail(email, password).then((registerStatus) async {
    if (registerStatus == AuthStatus.loginSuccess) {
      await secureStorage.write(key: 'islogin', value: "on");
      await secureStorage.write(key: 'email', value: email);
      await secureStorage.write(key: 'password', value: password);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('로그인 완료')),
        );
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('로그인 실패')),
        );
    }
  });
}
