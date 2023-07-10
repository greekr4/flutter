

import 'dart:convert';

import 'package:news_app/model/news.dart';
import 'package:http/http.dart' as http;


class NewsProviders{
  Uri uri = Uri.parse("https://newsapi.org/v2/top-headlines?apiKey=41600180295d4c7cb9d474d6712e7d59&country=kr");


  Future<List<News>> getNews() async {
    List<News> news = [];

    final response = await http.get(uri);

    if(response.statusCode == 200){
      news = jsonDecode(response.body)['articles'].map<News>( (article) {
        return News.fromMap(article);
      }).toList();
    }

    return news;
  }
}