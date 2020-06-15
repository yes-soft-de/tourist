// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Tourists`
  String get title {
    return Intl.message(
      'Tourists',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to `
  String get welcome {
    return Intl.message(
      'Welcome to ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `I want to enjoy your services while I'm in Saudi Arabia`
  String get card_01 {
    return Intl.message(
      'I want to enjoy your services while I\'m in Saudi Arabia',
      name: 'card_01',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get go_to_tourist_login {
    return Intl.message(
      'Next',
      name: 'go_to_tourist_login',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register a new Account`
  String get move_to_register {
    return Intl.message(
      'Register a new Account',
      name: 'move_to_register',
      desc: '',
      args: [],
    );
  }

  /// `I have an account!`
  String get move_to_login {
    return Intl.message(
      'I have an account!',
      name: 'move_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register_submit {
    return Intl.message(
      'Register',
      name: 'register_submit',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get form_label_name {
    return Intl.message(
      'Name',
      name: 'form_label_name',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}