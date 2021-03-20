import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/ui/widgets/add_location_dialog/add_location_dialog.dart';
import 'package:tourists/module_locations/ui/widgets/guide_locations/guide_locations.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/widget/profile_form_widget.dart';
import 'package:tourists/module_search/bloc/search_bloc/search_bloc.dart';
import 'package:tourists/utils/keyboard_detector/keyboard_detector.dart';

import 'edit_profile_state.dart';

class EditProfileStateGuideLoadSuccess extends EditProfileState {
  final ProfileModel userProfile;
  final SearchBloc _searchBloc;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final languages = <String>{};
  final locations = <String>{};
  final services = <String>{};

  EditProfileStateGuideLoadSuccess(
    MyProfileScreen screen,
    this.userProfile,
    this._searchBloc,
  ) : super(screen) {
    if (userProfile == null) {
      return;
    }

    languages.addAll(userProfile.languages ?? []);
    locations.addAll(userProfile.locations ?? []);
    services.addAll(userProfile.services ?? []);

    if (userProfile != null) {
      _nameController.text = userProfile.name;
      _phoneController.text = userProfile.phone;
    }
  }

  @override
  Widget getUI(BuildContext context) {
    var profile = userProfile;
    profile ??= ProfileModel();

    return GuideProfileFormWidget(
      searchBloc: _searchBloc,
      userProfile: userProfile,
      onImageSelected: (imagePath, profileModel) {
        screen.onImageSelected(imagePath, profileModel);
      },
      onProfileSaved: (profile) {
        screen.saveProfile(profile);
      },
    );
  }

}
