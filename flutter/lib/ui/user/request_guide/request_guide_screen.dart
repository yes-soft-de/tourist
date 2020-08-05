import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/request_guide/request_guide.bloc.dart';
import 'package:tourists/components/user/user_routes.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/location_details/location_details.dart';
import 'package:tourists/nav_arguments/request_guide/request_guide_navigation.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
class RequestGuideScreen extends StatefulWidget {
  final String tag = "RequestGuideScreen";

  final RequestGuideBloc _requestGuideBloc;
  final Logger _logger;

  RequestGuideScreen(this._requestGuideBloc, this._logger);

  @override
  State<StatefulWidget> createState() => _RequestGuideScreenState();
}

class _RequestGuideScreenState extends State<RequestGuideScreen> {
  int currentStatus = RequestGuideBloc.STATUS_CODE_INIT;

  final TextEditingController _arrivalDateField = TextEditingController();
  final TextEditingController _stayingTime = TextEditingController();

  RequestGuideNavigationArguments _requestGuideArguments;
  String _arrivalCity;
  DateTime _arrivalDate;
  String _guideLanguage;

  static const KEY_CAR = 'car';
  static const KEY_HOTEL = 'hotel';

  GuideListItemModel _guideInfo;
  LocationDetailsModel _locationInfo;

  Map<String, bool> servicesMap = {KEY_CAR: false, KEY_HOTEL: false};
  bool locationMode = false;
  bool requestInProgress = false;

  @override
  Widget build(BuildContext context) {
    _requestGuideArguments = ModalRoute.of(context).settings.arguments;

    // region Setting up
    if (_requestGuideArguments == null) {
      return Scaffold(
        body: Center(
          child: Text("Null Arguments"),
        ),
      );
    }

    if (_requestGuideArguments.guideId == null &&
        _requestGuideArguments.cityId == null) {
      return Scaffold(
        body: Center(
          child: Text("Null Arguments"),
        ),
      );
    }

    if (_requestGuideArguments.guideId == null &&
        _requestGuideArguments.cityId != null) {
      locationMode = true;
    }

    widget._logger.info(widget.tag, "Mode: " + this.locationMode.toString());
    // endregion

    // listen for guide Info
    widget._requestGuideBloc.guideInfoStream.listen((event) {
      currentStatus = event.first;
      requestInProgress = false;
      if (currentStatus == RequestGuideBloc.STATUS_CODE_LOAD_SUCCESS) {
        locationMode ? _locationInfo = event.last : _guideInfo = event.last;
        widget._logger.info(widget.tag, "Guide Info: " + _guideInfo.toString());
      }
      setState(() {});
    });

    if (currentStatus == RequestGuideBloc.STATUS_CODE_INIT) {
      if (locationMode) {
        widget._requestGuideBloc
            .getLocationWithId(_requestGuideArguments.cityId);
      } else {
        widget._requestGuideBloc.getGuideWithId(_requestGuideArguments.guideId);
      }
      return Scaffold(
        body: Center(
          child: Text('Loading ;)'),
        ),
      );
    }

    if (currentStatus == RequestGuideBloc.STATUS_CODE_LOAD_ERROR) {
      Fluttertoast.showToast(msg: "Error Sending Request!");
      return Scaffold(
        body: Center(
          child: Text('Error Loading data'),
        ),
      );
    }

    if (currentStatus == RequestGuideBloc.STATUS_CODE_REQUEST_SUCCESS) {
      // Go to Home
      Fluttertoast.showToast(msg: "Request Sent!");
      Navigator.pushReplacementNamed(context, UserRoutes.home);
      return Scaffold(
        body: Center(
          child: Text('Success'),
        ),
      );
    }

    if (currentStatus == RequestGuideBloc.STATUS_CODE_LOAD_SUCCESS ||
        currentStatus == RequestGuideBloc.STATUS_CODE_REQUEST_SUCCESS ||
        currentStatus == RequestGuideBloc.STATUS_CODE_REQUEST_ERROR) {
      return _buildUI();
    }

    return Center(
      child: Text("Undefined State" + currentStatus.toString()),
    );
  }

  Scaffold _buildUI() {
    List<Widget> pageLayout = [];

    if (locationMode) {
      pageLayout.add(AppBar(
        backgroundColor: Colors.white,
        title: Text("Make a General Request"),
      ));
    } else {
      pageLayout.add(AppBar(
        backgroundColor: Colors.white,
        title: Text("Request a Guide"),
      ));
    }
    pageLayout.add(_getScreenHeader());

    List<String> availableLanguage = [];

    if (locationMode) {
      availableLanguage = ["Arabic", "English"];
    } else {
      availableLanguage = _guideInfo.language;
    }

    // region Language Selector
    List<DropdownMenuItem<String>> languageList = [];
    availableLanguage.forEach((guideLanguage) {
      languageList.add(
        DropdownMenuItem(
          value: guideLanguage,
          child: Text(guideLanguage),
        ),
      );
    });
    Widget languageSelector = DropdownButtonFormField(
      items: languageList,
      hint: Text('Expected Communication Language'),
      onChanged: (String value) {
        this._guideLanguage = value;
      },
    );
    pageLayout.add(Padding(
      padding: const EdgeInsets.all(16.0),
      child: languageSelector,
    ));
    // endregion

    if (!locationMode) {
      // region City Selector
      List<DropdownMenuItem<String>> locationList = [];
      _guideInfo.city.forEach((guideLocation) {
        locationList.add(
          DropdownMenuItem(
            value: guideLocation,
            child: Text(guideLocation),
          ),
        );
      });
      Widget locationSelector = DropdownButtonFormField(
        items: locationList,
        hint: Text('Target City'),
        onChanged: (String value) {
          this._arrivalCity = value;
        },
      );

      if (_requestGuideArguments.cityId != null) {}

      pageLayout.add(Padding(
        padding: const EdgeInsets.all(16.0),
        child: locationSelector,
      ));
      // endregion
    }

    // region Dates
    Flex datesRow = Flex(
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
    );
    pageLayout.add(Padding(
      padding: const EdgeInsets.all(16.0),
      child: datesRow,
    ));
    // endregion

    // region Services Checklist
    Flex servicesContainer = Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Text('Services'),
        CheckboxListTile(
            title: Text('Car'),
            secondary: Icon(Icons.local_taxi),
            value: servicesMap[KEY_CAR],
            onChanged: (bool value) {
              servicesMap[KEY_CAR] = value;
              setState(() {});
            }),
        CheckboxListTile(
            title: Text('Hotel'),
            secondary: Icon(Icons.hotel),
            value: servicesMap[KEY_HOTEL],
            onChanged: (bool value) {
              servicesMap[KEY_HOTEL] = value;
              setState(() {});
            })
      ],
    );
    pageLayout.add(servicesContainer);
    // endregion

    // region Next
    pageLayout.add(Padding(
      padding: EdgeInsets.all(16),
      child: RaisedButton(
        onPressed: requestInProgress ? null : () {
          if (!locationMode) {
            _requestGuide();
          } else {
            _requestLocation();
          }
        },
        color: Colors.greenAccent,
        child: Text('Request a Chat!'),
      ),
    ));
    // endregion

    return Scaffold(
      body: ListView(
        children: pageLayout,
      ),
    );
  }

  _getStarsLine(double starCount) {
    if (starCount == null) starCount = 5;
    List<Widget> stars = [];
    for (int i = 0; i < starCount; i++) {
      stars.add(Icon(Icons.star));
    }

    return Flex(
      direction: Axis.horizontal,
      children: stars,
    );
  }

  _requestGuide() {
    log("Request the guide");
    List<String> servicesList = [];
    servicesMap.forEach((key, value) {
      if (value == true) servicesList.add(key);
    });
    widget._requestGuideBloc.requestGuide(
        _requestGuideArguments.guideId,
        servicesList,
        DateTime.parse(_arrivalDateField.text),
        int.parse(_stayingTime.text),
        _guideLanguage,
        _arrivalCity);
  }

  _requestLocation() {
    log("Request a City");
    List<String> servicesList = [];
    servicesMap.forEach((key, value) {
      if (value == true) servicesList.add(key);
    });
    widget._requestGuideBloc.requestGuide(
        _requestGuideArguments.guideId,
        servicesList,
        DateTime.parse(_arrivalDateField.text),
        int.parse(_stayingTime.text),
        _guideLanguage,
        _arrivalCity);
  }

  Widget _getScreenHeader() {
    if (locationMode) {
      return Row(
        children: <Widget>[
          Container(
            height: 120,
            width: 160,
            child: _locationInfo.paths[0].path != null
                ? Image.network(
                    _locationInfo.paths[0].path,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.perm_identity),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Text(
                  _locationInfo.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Container(
            height: 120,
            width: 160,
            child: _guideInfo.image != null
                ? Image.network(
                    _guideInfo.image,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.perm_identity),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Text(
                  _guideInfo.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                _getStarsLine(_guideInfo.rating),
                Text(
                    _guideInfo.status != null ? _guideInfo.status : 'Available')
              ],
            ),
          )
        ],
      );
    }
  }
}
