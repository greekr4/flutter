import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newflutter/models/model_auth.dart';
import 'package:provider/provider.dart';

class TabProfile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile"),
          LoginOutButton(),
        ],
      ),
    );
  }
}






class LoginOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final authClient = Provider.of<FirebaseAuthProvider>(context,listen: false);

    return TextButton(
        onPressed: () async {
          await authClient.logout();
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('Bye!')));
          Navigator.of(context).pushReplacementNamed('/login');
        }, child: Text('logout'));
  }
}

