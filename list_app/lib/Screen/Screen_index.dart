

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_app/Model/Model_person.dart';


class ScreenIndex extends StatelessWidget {




  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(title: Text('용상부'),),
      body: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index){
            if(index == 0) return HeaderTile();
            return PersonTile(Person(index,'이용상${index}',(index % 2 == 1) ? true : false));
          })
    );

  }

}


class HeaderTile extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      child: Image.network("https://cdn.crowdpic.net/detail-thumb/thumb_d_2F583E5543F7E19139C6FCFFBF9607A6.jpg"),
    );
  }
}

class PersonTile extends StatelessWidget{
  PersonTile(this._person);
  final Person _person;


  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(_person.name),
      subtitle: Text('${_person.age}세'),
      trailing: IconButton(onPressed: () { print('클릭함'); }, icon: _person.isLeftHand ? Icon(Icons.add_call) : Icon(Icons.clear_all) ) ,

    );
  }
}