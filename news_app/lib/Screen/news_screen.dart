

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/providers/news_providers.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState(){
    return new _NewsScreenState();
  }


}


class _NewsScreenState extends State<NewsScreen> {
  List<News> news = [];
  bool isLoading = true;
  NewsProviders newsProvider = NewsProviders();

  Future initNews() async {
    news = await newsProvider.getNews();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    initNews();
    return Scaffold(
      appBar: AppBar(
        title: Text('뉴스'),
      ),
      body: isLoading ? Center(child: const CircularProgressIndicator(),) : 
      GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, //한 행에 포함되는 열의 개수
        childAspectRatio: 1/0.5, //가로너비와 세로높이 비율 2:3
        crossAxisSpacing: 20, //열 사이 간격
        mainAxisSpacing: 5 // 행 사이 간격
      ),
          itemCount: news.length,
          itemBuilder: (context,index) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(news[index].title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),maxLines: 2),
              Text(news[index].content,maxLines: 4),
              Text('더보기',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold)),
            ],
          ),
        );
          })
      ,
    );
  }

}