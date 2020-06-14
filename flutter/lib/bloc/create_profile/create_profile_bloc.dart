import 'package:rxdart/rxdart.dart';
import 'package:tourists/services/profile/profile.service.dart';

class CreateProfileBloc {
  ProfileService _profileService;

  CreateProfileBloc(this._profileService);

  final _profileChecker = PublishSubject<String>();

  Stream<String> get loginStatus => _profileChecker.stream;

  login(dynamic profile) async {
    // Allocate Profile
    String createProfileResponse = await _profileService.createProfile(null);

    _profileChecker.add(createProfileResponse);
  }

  dispose() {
    _profileChecker.close();
  }
}