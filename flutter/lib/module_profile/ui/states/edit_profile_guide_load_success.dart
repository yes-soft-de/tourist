import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_profile/response/profile_response/profile_response.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';

import 'edit_profile_state.dart';

class EditProfileStateGuideLoadSuccess extends EditProfileState {
  ProfileResponse profileResponse;
  EditProfileStateGuideLoadSuccess(MyProfileScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold();
  }
}