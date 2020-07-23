import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationListItemWidget extends StatelessWidget {
  final String imageLink;
  final String title;
  final String description;
  final int commentsNumber;
  final int rate;

  LocationListItemWidget(
      {Key key,
      this.rate,
      this.title,
      this.description,
      this.commentsNumber,
      this.imageLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                height: 128,
                width: 128,
                child: Image.network(
                  imageLink,
                  fit: BoxFit.fitHeight,
                ),
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Icon(
                                  Icons.comment,
                                  size: 16,
                                ),
                              ),
                              Text(
                                commentsNumber.toString() + ' Comments',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            children: getStarsBar(rate),
                          )
                        ],
                      ),
                    ]),
              ),
            )
          ]),
    );
  }

  List<Widget> getStarsBar(int rate) {
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
