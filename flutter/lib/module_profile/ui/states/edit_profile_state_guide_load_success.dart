import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/utils/keyboard_detector/keyboard_detector.dart';

import 'edit_profile_state.dart';

class EditProfileStateGuideLoadSuccess extends EditProfileState {
  final ProfileModel userProfile;
  final _nameController = TextEditingController();

  final languages = <String>{};
  final locations = <String>{};

  EditProfileStateGuideLoadSuccess(MyProfileScreen screen, this.userProfile)
      : super(screen) {
    languages.addAll(userProfile.languages);
    locations.addAll(userProfile.locations);
  }

  @override
  Widget getUI(BuildContext context) {
    var profile = userProfile;
    profile ??= ProfileModel();

    var picker = ImagePicker();
    return Form(
      child: Flex(
        direction: Axis.vertical,
        children: [
          !KeyboardDetector.isUp(context)
              ? Container(
            height: 88,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned.fill(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'resources/images/logo.jpg',
                      image: '${profile.image}'.contains('http')
                          ? '${profile.image}'
                          : Urls.imagesRoot + '${profile.image}',
                      fit: BoxFit.contain,
                      imageErrorBuilder: (o, e, s) {
                        return Image.asset('resources/images/logo.jpg');
                      },
                    )),
                Positioned(
                  right: 16,
                  top: 16,
                  child: GestureDetector(
                    onTap: () {
                      picker
                          .getImage(
                          source: ImageSource.gallery,
                          imageQuality: 70)
                          .then((image) {
                        if (image != null) {
                          screen.onImageSelected(image.path, profile);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
              : Container(),
          ListTile(
            title: TextFormField(
              controller: _nameController,
              onEditingComplete: () {
                profile.name = _nameController.text;
              },
              decoration: InputDecoration(
                labelText: S.of(context).myName,
                hintText: S.of(context).myName,
              ),
            ),
          ),
          ListTile(
            title: Text(
              S.of(context).language,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          CheckboxListTile(
            title: Text(S.of(context).language_arabic),
            value: languages.contains('ar'),
            onChanged: (bool value) {
              if (value) {
                languages.add('ar');
              } else {
                languages.remove('ar');
              }
              profile.languages = languages.toList();
              screen.refresh(profile);
            },
          ),
          CheckboxListTile(
            title: Text(S.of(context).language_english),
            value: profile.languages.contains('en'),
            onChanged: (bool value) {
              if (value) {
                languages.add('en');
              } else {
                languages.remove('en');
              }
              profile.languages = languages.toList();
              screen.refresh(profile);
            },
          ),
          GestureDetector(
            onTap: () {
              var createProfileRequest = ProfileModel(
                name: _nameController.text,
                image: profile.image,
                languages: languages.toList(),
              );
              screen.saveProfile(createProfileRequest);
            },
            child: Container(
              decoration:
              BoxDecoration(color: Theme.of(context).accentColor),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).profile,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
