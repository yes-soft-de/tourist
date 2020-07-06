import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/user_routes.dart';

@provide
class OrderGuideScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderGuideScreenState();
}

class _OrderGuideScreenState extends State<OrderGuideScreen> {
  final TextEditingController _arrivalDateField = TextEditingController();
  final TextEditingController _stayingTime = TextEditingController();
  DateTime _arrivalDate;

  String _guideLanguage;
  String _destination;

  @override
  Widget build(BuildContext context) {
    List<Widget> pageLayout = [];

    pageLayout.add(Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 96,
            height: 96,
            child: Image.network(
              'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Mohammad',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            getRatingBar(),
            Text(
              'Available',
              style: TextStyle(color: Colors.greenAccent),
            )
          ],
        )
      ],
    ));

    // Language Selector
    pageLayout.add(DropdownButtonFormField(
      items: <DropdownMenuItem<String>>[
        DropdownMenuItem(
          value: null,
          child: Text('Select a Language'),
        ),
        DropdownMenuItem(
          value: 'en',
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: 'ar',
          child: Text('العربية'),
        ),
      ],
      onChanged: (String value) {
        this._guideLanguage = value;
      },
    ));


    List<DropdownMenuItem<String>> locationList = [];

    // Append Cities
    for (int i = 0; i < 5; i++) {
      locationList.add(
        DropdownMenuItem(
          value: 'city ' + i.toString(),
          child: Text('city #' + i.toString()),
        ),
      );
    }

    pageLayout.add(DropdownButtonFormField(
      items: locationList,
      onChanged: (value) {
        _destination = value;
      },
    ));

    pageLayout.add(Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  TextFormField(
                    controller: _arrivalDateField,
                    decoration: InputDecoration(labelText: 'Arrival Date'),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      child: Container(
                        color: Color(0x01FFFFFF),
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year,
                              DateTime.now().month + 4, DateTime.now().day),
                        ).then((value) {
                          _arrivalDate = value;
                          _arrivalDateField.text =
                              _arrivalDate.toIso8601String().substring(0, 10);
                          log('Arrival date set to ' +
                              _arrivalDate.toIso8601String().substring(0, 10));
                        });
                      },
                    ),
                  )
                ],
              ),
            )),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    controller: _stayingTime,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Staying for'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                    child: Text('Days'),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));

    // Services
    pageLayout.add(Text('Services'));
    pageLayout.add(CheckboxListTile(
      title: const Text('Car'),
      value: false,
      secondary: const Icon(Icons.directions_car),
      onChanged: (bool value) {
        log(value ? 'Car is Requested' : 'Car is Not Required');
      },
    ));
    pageLayout.add(CheckboxListTile(
      title: const Text('Car'),
      value: false,
      secondary: const Icon(Icons.hotel),
      onChanged: (bool value) {
        log(value ? 'Hotel is Requested' : 'Hotel is Not Required');
      },
    ));

    pageLayout.add(RaisedButton(
      onPressed: () {
        log('Submit Pressed');
        Navigator.pushReplacementNamed(context, UserRoutes.requestGuideSent);
      },
      child: Text('Send Request...'),
    ));

    return Scaffold(
      body: ListView(
        children: pageLayout,
      )
    );
  }

  Widget getRatingBar() {
    List<Widget> stars = [];

    for (int i = 0; i < 3; i++) {
      stars.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(Icons.star),
      ));
    }

    return Flex(
      direction: Axis.horizontal,
      children: stars,
    );
  }
}
