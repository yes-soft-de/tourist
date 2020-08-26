import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';
import 'package:tourists/utils/language/language.dart';

@provide
class SettingsScreen extends StatefulWidget {
  final AuthGuard authGuard;
  final LanguageHelper languageHelper;

  SettingsScreen(this.authGuard, this.languageHelper);

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
                      future: widget.authGuard.isLoggedIn(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.data == true) {
                          return FutureBuilder(
                            future: widget.authGuard.isGuide(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.data) {
                                return Text(S.of(context).guide);
                              }
                              return Text(S.of(context).tourist);
                            },
                          );
                        }
                        return Text(S.of(context).notLoggedIn);
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
            )
          ],
        ),
      ),
    );
  }
}
