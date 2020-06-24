import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

class GuideListItem extends StatelessWidget {
  final String guideName;
  final String guideLanguage;
  final String guideImage;
  final bool availability;
  final double rate;
  final String guideCity;

  GuideListItem(
      {Key key,
      @required this.guideName,
      @required this.guideImage,
      @required this.guideLanguage,
      @required this.rate,
      @required this.guideCity,
      @required this.availability});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // TODO: Show Profile when clicking on image
            // Image
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90))),
              child: Image.network(
                guideImage,
                fit: BoxFit.contain,
              ),
            ),
            // Info
            Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Text(
                  guideName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(guideLanguage + ' / ' + guideCity),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(
                      availability
                          ? S.of(context).available
                          : S.of(context).not_available,
                      style: TextStyle(
                          color:
                              availability ? Colors.greenAccent : Colors.red),
                    ),
                    getStarsLine()
                  ],
                )
              ],
            ),
            // TODO: Move to Request Guide When this Clicked
            // Request Button
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                  border: Border.all(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  Widget getStarsLine() {
    List<Widget> starsLine = [];

    for (int i = 0; i < rate; i++) {
      starsLine.add(Icon(Icons.star));
    }

    return Flex(
      direction: Axis.horizontal,
      children: starsLine,
    );
  }
}
