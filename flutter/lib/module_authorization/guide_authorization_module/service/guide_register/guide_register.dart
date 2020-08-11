import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_authorization/guide_authorization_module/manager/guide_register/guide_register.dart';
import 'package:tourists/module_authorization/guide_authorization_module/request/register_guide/register_guide.dart';
import 'package:tourists/module_authorization/guide_authorization_module/request/update_guide/update_guide.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/response/guide_response/guides_response.dart';
import 'package:tourists/module_guide/service/guide_list/guide_list.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class GuideRegisterService {
  final GuideRegisterManager _guideRegisterManager;
  final SharedPreferencesHelper _preferencesHelper;
  final GuideListService _guideListService;
  final FirebaseAuth _authService = FirebaseAuth.instance;

  GuideRegisterService(this._guideRegisterManager, this._preferencesHelper,
      this._guideListService);

  Future<bool> registerGuide(String name, String uid) async {
    RegisterGuideRequest request = new RegisterGuideRequest();
    request.name = name;
    request.userID = uid;
    request.email = uid;
    request.password = uid.hashCode.toString();
    request.roles = "guide";

    dynamic response = await _guideRegisterManager.registerGuide(request);
    if (response == null) return false;
    return true;
  }

  Future<bool> checkIfRegistered() async {
    FirebaseUser user = await _authService.currentUser();
    String uid = user.uid;

    List<GuideListItemModel> guidesList =
        await _guideListService.getAllGuides();

    bool guideLoggedId = false;

    guidesList.forEach((element) {
      if (element.userID == uid) {
        log("User Already Exists with ID: " + uid);
        guideLoggedId = true;
      }
    });

    return guideLoggedId;
  }

  Future<bool> updateGuide(UpdateGuideRequest updateGuideRequest) async {
    GuidesResponse response = await _guideRegisterManager.updateGuide(updateGuideRequest);

    if (response != null) {
      return false;
    } else {
      return true;
    }
  }
}
