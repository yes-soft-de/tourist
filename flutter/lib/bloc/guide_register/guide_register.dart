import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/services/guide_register/guide_register.dart';

@provide
class GuideRegisterBloc {
  static const int STATUS_CODE_INIT = 1120;
  static const int STATUS_CODE_USER_ALREADY_LOGGED_IN = 1130;
  static const int STATUS_CODE_REGISTER_SUCCESS = 1140;
  static const int STATUS_CODE_REGISTER_ERROR = 1150;

  final GuideRegisterService _guideRegisterService;
  GuideRegisterBloc(this._guideRegisterService);

  PublishSubject<Pair<int, dynamic>> _guideRegisterSubject = new PublishSubject();
  Stream<Pair<int, dynamic>> get guideStream => _guideRegisterSubject.stream;

  registerGuide(String name, String language) {
    _guideRegisterService.registerGuide(name).then((value) {
      if (value == null || value == false) {
        _guideRegisterSubject.add(Pair(STATUS_CODE_REGISTER_ERROR, null));
      }
      _guideRegisterSubject.add(Pair(STATUS_CODE_REGISTER_SUCCESS, null));
    });
  }

  checkIfGuideRegistered() {
    _guideRegisterService.checkIfRegistered();
  }
}