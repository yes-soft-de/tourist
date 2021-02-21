import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';
import 'package:tourists/utils/language/language.dart';

@provide
class SettingsScreen extends StatefulWidget {
  final AuthService _authService;
  final LanguageHelper languageHelper;

  SettingsScreen(this.languageHelper, this._authService,);

  @override
  State<StatefulWidget> createState() => __SettingsScreenState();
}

class __SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(S.of(context).settings),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).loggedIn,
                      style: TextStyle(fontSize: 16),
                    ),
                    FutureBuilder(
                      future: widget._authService.isLoggedIn,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.data == true) {
                          return FutureBuilder(
                            future: widget._authService.userRole,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.data == UserRole.ROLE_GUIDE) {
                                return Text(S.of(context).guide);
                              }
                              return Text(S.of(context).tourist);
                            },
                          );
                        }
                        return GestureDetector(
                            onTap: () {
                              FirebaseAuth.instance.signOut().then((value) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomeRoutes.home,
                                  (route) => false,
                                );
                              });
                            },
                            child: Text(S.of(context).notLoggedIn));
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).language,
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton(
                        value: Localizations.localeOf(context).toString(),
                        onChanged: (newLocal) {
                          print('Setting local $newLocal');
                          widget.languageHelper.setLanguage(newLocal);
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: 'ar',
                            child: Text('العربية'),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
            Container(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).logout,
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(icon: Icon(Icons.logout), onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeRoutes.home,
                              (route) => false,
                        );
                      });
                    }),
                  ],
                ),
              ),
            ),
            Container(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
