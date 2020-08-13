import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_authorization/guide_authorization_module/bloc/guide_register/guide_register.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_locations/service/location_list/location_list_service.dart';

@provide
class GuideProfileScreen extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final LocationListService locationListService;
  final GuideRegisterBloc _guideRegisterBloc;

  GuideProfileScreen(this.locationListService, this._guideRegisterBloc);

  @override
  State<StatefulWidget> createState() => _GuideProfileScreenState();
}

class _GuideProfileScreenState extends State<GuideProfileScreen> {
  int step = 0;
  bool editMode = false;

  PageController signUpController = PageController(initialPage: 0);

  String _userId;
  List<String> _languages = [];
  List<String> _cities = [];
  List<String> _availableLocations;
  String _phoneNumber;
  List<String> _services = [];

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _aboutMeController = new TextEditingController();
  TextEditingController _costPerDayController = new TextEditingController();

  int currentState = GuideRegisterBloc.STATUS_CODE_INIT;

  @override
  Widget build(BuildContext context) {
    if (_availableLocations == null) {
      _getLocations();
    }

    widget.auth.currentUser().then((value) {
      _phoneNumber = value.phoneNumber;
      _userId = value.uid;
    });

    widget._guideRegisterBloc.guideStream.listen((event) {
      currentState = event.first;
      if (currentState != GuideRegisterBloc.STATUS_CODE_UPDATE_SUCCESS)
        setState(() {});
    });

    switch (currentState) {
      case GuideRegisterBloc.STATUS_CODE_INIT:
        _checkIfRegistered();
        return _getContactInfoPage();
      case GuideRegisterBloc.STATUS_CODE_USER_ALREADY_LOGGED_IN:
        editMode = true;
        return _signUpPages();
      case GuideRegisterBloc.STATUS_CODE_EDIT_MODE:
        return _getServicesPage();
      case GuideRegisterBloc.STATUS_CODE_LOADING:
        return _getLoadingScreen();
      case GuideRegisterBloc.STATUS_CODE_REGISTER_SUCCESS:
        return _getServicesPage();
      case GuideRegisterBloc.STATUS_CODE_UPDATE_SUCCESS:
        Navigator.pushReplacementNamed(context, HomeRoutes.guideHome);
        return Scaffold();
      case GuideRegisterBloc.STATUS_CODE_REGISTER_ERROR:
        Fluttertoast.showToast(msg: 'Error Saving Profile');
        return _getContactInfoPage();
      case GuideRegisterBloc.STATUS_CODE_UPDATE_ERROR:
        Fluttertoast.showToast(msg: 'Error Saving Data');
        return _getServicesPage();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Soyah'),
        ),
        body: Center(
          child: Text('Undefined State ' + currentState.toString()),
        ));
  }

  Scaffold _getLoadingScreen() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('سياح'),
        ),
        body: Center(child: CircularProgressIndicator()));
  }

  PageView _signUpPages() {
    return PageView(
      controller: signUpController,
      children: <Widget>[_getContactInfoPage(), _getServicesPage()],
    );
  }

  Scaffold _getServicesPage() {
    List<Widget> pageLayout = [];

    pageLayout.add(TextFormField(
      controller: _costPerDayController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: 'Cost Per Day'),
    ));

    pageLayout.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Services You can Offer'),
    ));
    pageLayout.add(CheckboxListTile(
      title: Text('Car'),
      value: _services.contains('car'),
      onChanged: (bool value) {
        if (_services.contains('car')) {
          _services.remove('car');
        } else {
          _services.add('car');
        }
        setState(() {});
      },
    ));
    pageLayout.add(CheckboxListTile(
      title: Text('Hotel'),
      value: _services.contains('hotel'),
      onChanged: (bool value) {
        if (_services.contains('hotel')) {
          _services.remove('hotel');
        } else {
          _services.add('hotel');
        }
        setState(() {});
      },
    ));

    pageLayout.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Cities you operate in'),
    ));
    pageLayout.add(_getCitiesInFlex());

    pageLayout.add(RaisedButton(
      onPressed: () => _updateGuideProfile(),
      child: Text('Submit Details'),
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('سياح'),
      ),
      body: SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          children: pageLayout,
        ),
      ),
    );
  }

  Scaffold _getContactInfoPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('سياح'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Flex(
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
                if (editMode == false) {
                  _createGuideProfile();
                } else {
                  signUpController.jumpToPage(1);
                }
              },
              child: Text('Next'),
            )
          ],
        ),
      ),
    );
  }

  Widget _getCitiesInFlex() {
    List<Widget> _cityTiles = [];

    if (_availableLocations != null) {
      _availableLocations.forEach((city) {
        _cityTiles.add(CheckboxListTile(
          title: Text(city),
          onChanged: (active) {
            if (_cities.contains(city)) {
              _cities.remove(city);
            } else {
              _cities.add(city);
            }
            setState(() {});
          },
          value: _cities.contains(city),
        ));
      });
    }

    return SingleChildScrollView(
      child: Flex(
        direction: Axis.vertical,
        children: _cityTiles,
      ),
    );
  }

  _checkIfRegistered() {
    widget._guideRegisterBloc.checkIfGuideRegistered();
  }

  _getLocations() {
    _availableLocations = [];
    widget.locationListService.getLocationList().then((locationList) {
      locationList.forEach((city) {
        _availableLocations.add(city.name);
      });
      setState(() {});
    });
  }

  _createGuideProfile() {
    widget._guideRegisterBloc.registerGuide(_userNameController.text, _userId);
  }

  _updateGuideProfile() {
    widget._guideRegisterBloc.updateGuide(
      uid: _userId,
      phone: _phoneNumber,
      about: _aboutMeController.text,
      name: _userNameController.text,
      services: _services,
      cities: _cities,
      languages: _languages,
    );
  }
}
