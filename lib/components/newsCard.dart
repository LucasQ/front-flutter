import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterApp/components/cardView.dart';
import 'package:flutterApp/models/cardModel.dart';
import 'package:flutterApp/repository/newsRepository.dart';

class NewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildContainer(),
    );
  }

  Future<List<CardModel>> getNewsList() async {
    Future<List<CardModel>> news = NewsRepository.getNews();
    return news;
  }

  buildContainer() {
    return RefreshIndicator(
      onRefresh: getNewsList,
      child: FutureBuilder(
          future: getNewsList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CardModel> list = snapshot.data;
              return Container(child: cardView(list));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Algo deu errado',
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              );
            }
          }),
    );
  }
}
