import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state.dart';

class EditProfileStateError extends EditProfileState {
  String errorMsg;

  EditProfileStateError(MyProfileScreen screen, this.errorMsg) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('$errorMsg'),
    );
  }
}
