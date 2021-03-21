import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';
import 'package:tourists/module_locations/service/location_details/location_details_service.dart';
import 'package:tourists/module_locations/ui/screens/add_location/add_location.dart';
import 'package:tourists/module_locations/ui/states/add_location_state/add_location_state.dart';
import 'package:tourists/module_locations/ui/states/add_location_state/add_location_state_create_success.dart';
import 'package:tourists/module_locations/ui/states/add_location_state/add_location_state_init.dart';
import 'package:tourists/module_upload/service/image_upload/image_upload_service.dart';

@provide
class AddLocationBloc {
  final stateSubject = PublishSubject<AddLocationState>();

  final ImageUploadService _imageUploadService;
  final LocationDetailsService _locationDetailsService;

  AddLocationBloc(this._imageUploadService, this._locationDetailsService);

  void uploadImage(
    AddLocationScreen screen,
    String imagePath,
    LocationDetailsModel model,
  ) {
    model ??= LocationDetailsModel();
    _imageUploadService.uploadImage(imagePath).then((value) {
      model.paths ??= [];
      if (model.paths.isEmpty) {
        model.paths.add(DetailsImagePaths(path: Urls.imagesRoot + value));
      } else {
        model.paths = [DetailsImagePaths(path: value)];
      }
      stateSubject.add(AddLocationStateInit(screen, model));
    });
  }

  void saveLocation(AddLocationScreen screen, LocationDetailsModel model) {
    _locationDetailsService.updateLocation(model).then((value) {
      stateSubject.add(AddLocationStateCreateSuccess(
        screen,
        value.locationId,
      ));
    });
  }

  void getLocation(AddLocationScreen screen, String locationId) {
    _locationDetailsService.getLocationDetails(locationId).then((location) {
      stateSubject.add(AddLocationStateInit(screen, location));
    });
  }
}
