import 'package:inject/inject.dart';
import 'package:tourists/repositories/guides/guide_repository.dart';
import 'package:tourists/responses/guide_response/guides_response.dart';

@provide
class GuidesManager {
  GuidesRepository _guidesRepository;
  
  GuidesManager(this._guidesRepository);
  
  Future<GuidesResponse> getGuidesList() {
    return _guidesRepository.getGuidesList();
  }
  
  Future<GuidesResponse> getGuidesByLocationId(String locationId) {
    return _guidesRepository.getGuidesByArea(locationId);
  }
}