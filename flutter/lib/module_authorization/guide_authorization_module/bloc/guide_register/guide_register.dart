import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_authorization/guide_authorization_module/request/update_guide/update_guide.dart';
import 'package:tourists/module_authorization/guide_authorization_module/service/guide_register/guide_register.dart';

@provide
class GuideRegisterBloc {
  static const int STATUS_CODE_INIT = 1120;
  static const int STATUS_CODE_USER_ALREADY_LOGGED_IN = 1130;
  static const int STATUS_CODE_REGISTER_SUCCESS = 1140;
  static const int STATUS_CODE_REGISTER_ERROR = 1150;
  static const int STATUS_CODE_UPDATE_ERROR = 1160;
  static const int STATUS_CODE_UPDATE_SUCCESS = 1170;
  static const int STATUS_CODE_LOADING = 1180;

  final GuideRegisterService _guideRegisterService;

  GuideRegisterBloc(this._guideRegisterService);

  PublishSubject<Pair<int, dynamic>> _guideRegisterSubject =
      new PublishSubject();

  Stream<Pair<int, dynamic>> get guideStream => _guideRegisterSubject.stream;

  registerGuide(String name, String uid) {
    _guideRegisterSubject.add(Pair(STATUS_CODE_LOADING, null));
    _guideRegisterService.registerGuide(name, uid).then((value) {
      if (value == null || value == false) {
        _guideRegisterSubject.add(Pair(STATUS_CODE_REGISTER_ERROR, null));
      }
      _guideRegisterSubject.add(Pair(STATUS_CODE_REGISTER_SUCCESS, null));
    });
  }

  updateGuide(
      {@required String name,
      @required String uid,
      @required List<String> languages,
      @required List<String> cities,
      @required String phone,
      @required about,
      @required List<String> services}) {
    _guideRegisterSubject.add(Pair(STATUS_CODE_LOADING, null));
    _guideRegisterService
        .updateGuide(UpdateGuideRequest(
            name: name,
            user: uid,
            language: languages,
            city: cities,
            phoneNumber: phone,
            about: about,
            path:
                'https://www.fundermax.at/fileadmin/redakteure/_processed_/1/9/csm_0059_A4_5bc386ea8a.jpg',
            service: services))
        .then((value) {
      if (value == null) {
        _guideRegisterSubject.add(Pair(STATUS_CODE_UPDATE_ERROR, null));
      } else if (value == false) {
        _guideRegisterSubject.add(Pair(STATUS_CODE_UPDATE_ERROR, null));
      } else {
        _guideRegisterSubject.add(Pair(STATUS_CODE_UPDATE_SUCCESS, null));
      }
    });
  }

  checkIfGuideRegistered() {
    _guideRegisterService.checkIfRegistered().then((value) {
      if (value) {
        _guideRegisterSubject.add(Pair(STATUS_CODE_USER_ALREADY_LOGGED_IN, null));
      }
    });
  }
}
