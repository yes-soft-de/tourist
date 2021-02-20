import 'package:flutter/material.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';

abstract class EditProfileState {
  final MyProfileScreen screen;
  EditProfileState(this.screen);

  Widget getUI(BuildContext context);
}