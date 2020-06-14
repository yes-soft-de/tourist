import 'package:rxdart/rxdart.dart';
import 'package:tourists/requests/create_profile/create_profile_body.dart';
import 'package:tourists/services/profile/profile.service.dart';

class CreateProfileBloc {
  ProfileService _profileService;

  CreateProfileBloc(this._profileService);

  final _profileChecker = PublishSubject<bool>();

  Stream<bool> get profileStatus => _profileChecker.stream;

  createProfile(String name, String age, String gender, String language) async {

    CreateProfileBody profile =
        new CreateProfileBody(null, name, language, int.parse(age));

    var profileCreated = await this._profileService.createProfile(profile);

    if (profileCreated == null) {
      _profileChecker.add(false);
    }

    _profileChecker.add(true);
  }

  dispose() {
    _profileChecker.close();
  }
}
