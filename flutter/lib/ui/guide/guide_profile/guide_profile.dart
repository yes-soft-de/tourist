import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/services/location_list/location_list_service.dart';

@provide
class GuideProfileScreen extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final LocationListService locationListService;

  GuideProfileScreen(this.locationListService);

  @override
  State<StatefulWidget> createState() => _GuideProfileScreenState();
}

class _GuideProfileScreenState extends State<GuideProfileScreen> {
  int step = 0;
  PageController _profilePagesController = PageController();

  String _userId;
  String _userName;
  List<String> _languages = [];
  List<String> _cities;
  String _phoneNumber;
  String _about;
  String _cost;
  List<String> _services = ['Car', 'Hotel'];

  TextEditingController _userNameController;
  TextEditingController _aboutMeController;
  TextEditingController _costPerDayController;

  @override
  Widget build(BuildContext context) {
    if (_cities == null) {
      _getLocations();
    }

    widget.auth.currentUser().then((value) {
      _phoneNumber = value.phoneNumber;
      _userId = value.uid;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Soyah | Contact info'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: PageView(
            controller: _profilePagesController,
            children: <Widget>[
              Center(child: _getContactInfoPage()),
              Center(child: _getServicesInFlex())
            ],
          ),
        ),
      ),
    );
  }

  Flex _getServicesInFlex() {
    List<Widget> pageLayout = [];

    pageLayout.add(TextFormField(
      controller: _costPerDayController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: 'Cost Per Day'),
    ));

    pageLayout.add(_getCitiesInFlex());

    return Flex(
      direction: Axis.vertical,
      children: pageLayout,
    );
  }

  Flex _getCitiesInFlex() {
    List<Widget> _cityTiles = [];

    _cities.forEach((element) {
      _cityTiles.add(GestureDetector(
        onTap: () {
          if (_cities.contains(element)) {
            _cities.remove(element);
          } else {
            _cities.add(element);
          }
          setState(() {});
        },
        child: ListTile(
          title: Text(element),
          selected: _cities.contains(element),
        ),
      ));
    });

    return Flex(
      direction: Axis.vertical,
      children: _cityTiles,
    );
  }

  Flex _getContactInfoPage() {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        TextFormField(
          controller: _userNameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'Username'),
        ),
        TextFormField(
          controller: _aboutMeController,
          minLines: 3,
          maxLines: 5,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'About Me'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (_languages.contains('en')) {
                    _languages.remove('en');
                  } else {
                    _languages.add('en');
                  }
                  setState(() {});
                },
                child: Chip(
                  backgroundColor: _languages.contains('en')
                      ? Colors.greenAccent
                      : Colors.black26,
                  label: Text(
                    'English',
                    style: TextStyle(
                        color: _languages.contains('en')
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_languages.contains('ar')) {
                    _languages.remove('ar');
                  } else {
                    _languages.add('ar');
                  }
                  setState(() {});
                },
                child: Chip(
                  backgroundColor: _languages.contains('ar')
                      ? Colors.greenAccent
                      : Colors.black26,
                  label: Text(
                    'العربية',
                    style: TextStyle(
                        color: _languages.contains('ar')
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
        RaisedButton(
          onPressed: () {
            _profilePagesController.jumpToPage(1);
          },
          child: Text('Next'),
        )
      ],
    );
  }

  _getLocations() {
    widget.locationListService.getLocationList().then((locationList) {
      locationList.forEach((city) {
        _cities.add(city.name);
      });
    });

    setState(() {});
  }

  _createGuideProfile() {}
}
