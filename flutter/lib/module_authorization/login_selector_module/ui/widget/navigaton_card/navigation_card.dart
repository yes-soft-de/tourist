import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

class NavigationCard extends StatelessWidget {
  final String cardText;

  NavigationCard(this.cardText);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      // Sizing Container
      Container(
        height: 164,
      ),
      // Card Content
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Color(0xFFD5F4FE),
        ),
        alignment: Alignment.center,
        height: 128,
        width: 288,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            this.cardText,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ),
      // Move Button
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            height: 40,
            child: Container(
              alignment: Alignment.center,
              child: Container(
                height: 40,
                width: 160,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(90)),
                  color: Color(0xFF00FFA8),
                ),
                child: Text(
                  S.of(context).go_to_tourist_login,
                  style:
                  TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}