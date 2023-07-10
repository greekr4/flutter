import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newflutter/models/model_item_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class TabHome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return FutureBuilder(
      future: itemProvider.fetchItems(),
      builder: (context, snapshots) {
        if (itemProvider.items.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
              ),
              itemCount: itemProvider.items.length,
              itemBuilder: (context, index) {
                return GridTile(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/detail',
                        arguments: itemProvider.items[index]);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(itemProvider.items[index].imageUrl),
                            Padding(padding: EdgeInsets.all(10)),
                            Text(
                              itemProvider.items[index].title,
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              NumberFormat('#,###').format(itemProvider.items[index].price) + '원',
                              style: TextStyle(fontSize: 16, color: Colors.red),)
                          ],
                        ),
                      ),
                    )
                );
              }
          );
        }
      },
    );
  }
}