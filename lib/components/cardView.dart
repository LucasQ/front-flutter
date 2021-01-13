import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

cardView(List newsModel) {
  return ListView.builder(
    itemCount: newsModel.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      var item = newsModel[index];

      return Card(
          child: Padding(
        padding: EdgeInsets.only(left: 16.0, top: 12.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (item.headline != null)
                    Text(
                      item.headline,
                      maxLines: 2,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  Text(
                    item.title,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  Text(
                    item.subtitle,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black38,
                    ),
                  ),
                  if (item.image != null)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(padding: EdgeInsets.only(bottom: 10.0)),
                          Image.network(item.image,
                              height: 170, fit: BoxFit.fill)
                        ])
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.time,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(' - '),
                  Text(
                    item.category,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
          ],
        ),
      ));
    },
  );
}
