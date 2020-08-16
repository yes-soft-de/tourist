import 'package:inject/inject.dart';
import 'package:tourists/module_authorization/guide_authorization_module/repository/guide_register/guide_register.dart';
import 'package:tourists/module_authorization/guide_authorization_module/request/register_guide/register_guide.dart';
import 'package:tourists/module_authorization/guide_authorization_module/request/update_guide/update_guide.dart';
import 'package:tourists/module_guide/response/guide_response/guides_response.dart';

@provide
class GuideRegisterManager {
  final GuideRegisterRepository _repository;

  GuideRegisterManager(this._repository);

  Future<GuidesResponse> registerGuide(
      RegisterGuideRequest requestGuideRequest) {
    return _repository.registerGuide(requestGuideRequest);
  }

  Future<GuidesResponse> loginGuide() {
    return _repository.loginGuide();
  }

  Future<GuidesResponse> updateGuide(UpdateGuideRequest updateGuideRequest) {
    return _repository.updateGuide(updateGuideRequest);
  }
}
