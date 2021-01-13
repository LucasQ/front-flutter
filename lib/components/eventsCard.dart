import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterApp/components/cardView.dart';
import 'package:flutterApp/components/loginOptions.dart';
import 'package:flutterApp/models/cardModel.dart';
import 'package:flutterApp/repository/eventRepository.dart';

class EventsCard extends StatefulWidget {
  @override
  _EventsCardState createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildContainer(),
    );
  }

  Future<List<CardModel>> getNewsList() async {
    Future<List<CardModel>> news = EventRepository.getEvents();
    setState(() {});
    return news;
  }

  buildContainer() {
    final GlobalKey<_EventsCardState> _key = GlobalKey();

    return RefreshIndicator(
      onRefresh: getNewsList,
      child: FutureBuilder(
          future: getNewsList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CardModel> list = snapshot.data;
              return cardView(list);
            } else if (snapshot.hasError) {
              return Center(
                  child: LoginOptions(
                      key: _key,
                      getNewsList: getNewsList,
                      contextCard: context));
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
