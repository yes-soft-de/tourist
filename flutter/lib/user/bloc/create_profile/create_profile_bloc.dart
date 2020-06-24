import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/requests/create_profile/create_profile_body.dart';
import 'package:tourists/services/profile/profile.service.dart';

@provide
class CreateProfileBloc {
  ProfileService _profileService;
  final _profileCreationSubject = PublishSubject<bool>();

  CreateProfileBloc(this._profileService);
  Stream<bool> get profileStatus => _profileCreationSubject.stream;

  createProfile(String name, String gender, String language) async {

    CreateProfileBody profile =
        new CreateProfileBody(
          name: name,
          gender: gender,
          lang: language
        );

    var profileCreated = await this._profileService.createProfile(profile);

    if (profileCreated == null) {
      _profileCreationSubject.add(false);
    }

    _profileCreationSubject.add(true);
  }

  dispose() {
    _profileCreationSubject.close();
  }
}
