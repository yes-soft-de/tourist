import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

class CarouselCard extends StatelessWidget {
  final String _title;
  final String _description;
  final String _image;
  final int _stars;
  final int _commentsNumber;

  CarouselCard(this._title, this._description, this._image, this._stars,
      this._commentsNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              child: Image.network(
                _image,
                fit: BoxFit.fill,
              )),
          Container(
            height: 240,
            width: double.infinity,
            color: Color(0x2d000000),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _title,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container(
                  height: 8,
                ),
                Text(
                  _description,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Container(
                  height: 8,
                ),
                getStarsRow(),
                Container(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: Colors.white,
                    ),
                    Container(
                      width: 8,
                    ),
                    Text(
                      _commentsNumber.toString() + ' ' + S.of(context).comments,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getStarsRow() {
    double starSize = 20.0;
    List<Widget> starsRow = [];
    for (int i = 0; i < 5; i++) {
      starsRow.add(
        i >= _stars
            ? Icon(
                Icons.star,
                color: Color(0x88ffffff),
                size: starSize,
              )
            : Icon(
                Icons.star,
                color: Colors.white,
                size: starSize,
              ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: starsRow,
    );
  }
}
