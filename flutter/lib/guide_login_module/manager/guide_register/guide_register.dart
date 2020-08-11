import 'package:inject/inject.dart';
import 'package:tourists/repositories/guide_register/guide_register.dart';
import 'package:tourists/requests/register_guide/register_guide.dart';
import 'package:tourists/requests/update_guide/update_guide.dart';
import 'package:tourists/responses/guide_response/guides_response.dart';

@provide
class GuideRegisterManager {
  final GuideRegisterRepository _repository;
  GuideRegisterManager(this._repository);

  Future<GuidesResponse> registerGuide(RegisterGuideRequest requestGuideRequest) {
    return _repository.registerGuide(requestGuideRequest);
  }

  Future<GuidesResponse> loginGuide() {
    return _repository.loginGuide();
  }

  Future<GuidesResponse> updateGuide(UpdateGuideRequest updateGuideRequest) {
    return _repository.updateGuide(updateGuideRequest);
  }
}