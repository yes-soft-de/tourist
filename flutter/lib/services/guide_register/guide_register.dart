import 'dart:developer';

import 'package:inject/inject.dart';
import 'package:tourists/managers/guide_register/guide_register.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/requests/register_guide/register_guide.dart';
import 'package:tourists/services/guide_list/guide_list.dart';

@provide
class GuideRegisterService {
  final GuideRegisterManager _guideRegisterManager;
  final SharedPreferencesHelper _preferencesHelper;
  final GuideListService _guideListService;

  GuideRegisterService(this._guideRegisterManager, this._preferencesHelper, this._guideListService);

  Future<bool> registerGuide(
    String name,
  ) async {
    String uid = await _preferencesHelper.getUserUID();
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
    String uid = await _preferencesHelper.getUserUID();
    if (uid == null)
      return false;

    List<GuideListItemModel> guidesList = await _guideListService.getAllGuides();

    bool guideLoggedId = false;

    guidesList.forEach((element) {
      if (element.userID == uid) {
        log("User Already Exists with ID: " + uid);
        guideLoggedId = true;
      }
    });

    return guideLoggedId;
  }
}
