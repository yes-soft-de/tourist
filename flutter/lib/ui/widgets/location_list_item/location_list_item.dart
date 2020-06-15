import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationListItem {
  static Widget createLocationListItem(String imageLink, String title,
      String description, int comments, int rate) {
    return Container(
      height: 128,
      child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: FittedBox(
                child: Image.network(imageLink),
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            description,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.comment,
                                size: 16,
                              ),
                              Text(
                                comments.toString() + ' Comments',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            children: LocationListItem.getStarsBar(rate),
                          )
                        ],
                      ),
                    ]),
              ),
            )
          ]),
    );
  }

  static List<Widget> getStarsBar(int rate) {
    List<Widget> starsBar = new List();
    for (int i = 0; i < 5; i++) {
      i <= rate
          ? starsBar.add(Icon(
              Icons.star,
              size: 16,
            ))
          : starsBar.add(Icon(
              Icons.star_border,
              size: 16,
            ));
    }

    return starsBar;
  }
}
