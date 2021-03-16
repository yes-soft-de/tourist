import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state.dart';

class EditProfileStateSaveSuccess extends EditProfileState {
  EditProfileStateSaveSuccess(MyProfileScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle
        ),
        child: IconButton(icon: Icon(Icons.check), onPressed: () {
          Navigator.of(context).pushNamed(HomeRoutes.home);
        }),
      ),
    );
  }

}