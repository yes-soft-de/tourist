import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state.dart';

class EditProfileStateTouristLoadSuccess extends EditProfileState {
  ProfileModel profile;
  final _nameController = TextEditingController();
  final Set<String> languages = {};
  final Set<String> locations = {};

  EditProfileStateTouristLoadSuccess(MyProfileScreen screen, this.profile)
      : super(screen) {
    if (profile != null) {
      _nameController.text = profile.name;
    }
  }

  @override
  Widget getUI(BuildContext context) {
    profile ??= ProfileModel();
    var picker = ImagePicker();

    if (profile.languages != null) {
      if (profile.languages.isNotEmpty) {
        languages.addAll(profile.languages);
      }
    }

    if (profile.image != null) {
      // My old profile is here!!
      return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Container(
            height: 88,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned.fill(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'resources/images/logo.jpg',
                      image: profile.image.contains('http')
                          ? profile.image
                          : Urls.imagesRoot + profile.image,
                      fit: BoxFit.contain,
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
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
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
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  S.of(context).language,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Flex(
                direction: Axis.vertical,
                children: [
                  CheckboxListTile(
                    title: Text(S.of(context).language_arabic),
                    onChanged: (bool value) {
                      if (value) {
                        languages.add('ar');
                      } else {
                        languages.remove('ar');
                      }
                      profile.languages = languages.toList();
                      screen.refresh(profile);
                    },
                    value: profile.languages != null ? profile.languages.contains('ar') : false,
                  ),
                  CheckboxListTile(
                    title: Text(S.of(context).language_english),
                    onChanged: (bool value) {
                      if (value) {
                        languages.add('en');
                      } else {
                        languages.remove('en');
                      }
                      profile.languages = languages.toList();
                      print(profile.languages.toString());
                      screen.refresh(profile);
                    },
                    value: profile.languages != null ? profile.languages.contains('en') : false,
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              profile.name = _nameController.text;
              profile.languages = languages.toList();
              screen.saveProfile(profile);
            },
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).saveProfile,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    } else {
      // Upload My Picture
      return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 96,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'resources/images/logo.jpg',
                    fit: BoxFit.cover,
                    height: 88,
                    width: 88,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            picker
                                .getImage(
                                source: ImageSource.camera,
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
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: S.of(context).myName,
                    hintText: S.of(context).myName,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  screen.saveProfile(profile);
                },
                child: GestureDetector(
                  onTap: () {
                    screen.saveProfile(profile);
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
                            S.of(context).saveProfile,
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
              )
            ],
          )
        ],
      );
    }
  }
}
