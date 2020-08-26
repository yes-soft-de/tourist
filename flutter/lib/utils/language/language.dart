import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class LanguageHelper {
  static final PublishSubject<String> _languageSubject =
      PublishSubject<String>();
  Stream<String> get languageStream => _languageSubject.stream;

  final SharedPreferencesHelper _prefsHelper;

  LanguageHelper(this._prefsHelper);

  void getLanguage() {
    _prefsHelper.getCurrentLocal().then((value) {
      _languageSubject.add(value);
    });
  }

  void setLanguage(String newLang) {
    _prefsHelper.setCurrentLocal(newLang).then((value) {
      print('Updating Local to: $newLang');
      _languageSubject.add(newLang);
    });
  }

  void dispose() {
    _languageSubject.close();
  }
}
