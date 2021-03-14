import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

class GuideListItemWidget extends StatelessWidget {
  final String guideName;
  final String guideLanguage;
  final String guideImage;
  final String availability;
  final double rate;
  final String guideCity;

  GuideListItemWidget(
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
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  // Image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 56,
                        width: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        child: Text(
                          guideName[0],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        )),
                  ),
                  // Info
                  Expanded(
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          guideName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Text(
                              availability ?? S.of(context).available,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                            Container(
                              width: 8,
                            ),
                            getStarsLine()
                          ],
                        ),
                        Text(
                          '$guideCity | $guideLanguage',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Request Button
            GestureDetector(
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    border: Border.all(color: Colors.black)),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getStarsLine() {
    List<Widget> starsLine = [];

    for (int i = 0; i < rate; i++) {
      starsLine.add(Icon(
        Icons.star,
        size: 16,
      ));
    }

    return Flex(
      direction: Axis.horizontal,
      children: starsLine,
    );
  }
}
