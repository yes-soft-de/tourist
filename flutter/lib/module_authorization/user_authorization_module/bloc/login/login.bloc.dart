import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tourists/module_authorization/user_authorization_module/service/login/login.service.dart';
import 'package:tourists/module_authorization/user_authorization_module/states/login_state.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

@provide
class LoginBloc {
  final LoginService _loginService;
  final AuthGuard _authGuard;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc(this._loginService, this._authGuard);

  final _stateSubject = PublishSubject<LoginState>();

  Stream<LoginState> get loginStatus => _stateSubject.stream;

  void sendLoginEmail(String email) async {
    await _auth.sendSignInLinkToEmail(email: email).then((value) {
      // Send the User into a Email Sent Page
      _stateSubject.add(LoginStateEmailSent());
    }).catchError((err) {
      _stateSubject.add(LoginStateError(err.toString()));
    });
  }

  Future<void> authWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    var result = await FirebaseAuth.instance.signInWithCredential(credential);
    await _loginUser(result);
  }

  Future<void> signInWithApple() async {
    var oauthCred = await _createAppleOAuthCred();
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(oauthCred);
    await _loginUser(result);
  }

  Future<OAuthCredential> _createAppleOAuthCred() async {
    final nonce = _createNonce(32);
    final nativeAppleCred = Platform.isIOS
        ? await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            nonce: sha256.convert(utf8.encode(nonce)).toString(),
          )
        : await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            webAuthenticationOptions: WebAuthenticationOptions(
              redirectUri: Uri.parse(
                  'https://your-project-name.firebaseapp.com/__/auth/handler'),
              clientId: 'your.app.bundle.name',
            ),
            nonce: sha256.convert(utf8.encode(nonce)).toString(),
          );

    return new OAuthCredential(
      providerId: 'apple.com',
      // MUST be "apple.com"
      signInMethod: 'oauth',
      // MUST be "oauth"
      accessToken: nativeAppleCred.identityToken,
      // propagate Apple ID token to BOTH accessToken and idToken parameters
      idToken: nativeAppleCred.identityToken,
      rawNonce: nonce,
    );
  }

  String _createNonce(int length) {
    final random = Random();
    final charCodes = List<int>.generate(length, (_) {
      int codeUnit;

      switch (random.nextInt(3)) {
        case 0:
          codeUnit = random.nextInt(10) + 48;
          break;
        case 1:
          codeUnit = random.nextInt(26) + 65;
          break;
        case 2:
          codeUnit = random.nextInt(26) + 97;
          break;
      }

      return codeUnit;
    });

    return String.fromCharCodes(charCodes);
  }

  Future<bool> isSignedIn() async {
    return _loginService.isLoggedIn;
  }

  Future<void> _loginUser(UserCredential result) async {
    if (result != null) {
      bool loginSuccess = await _loginService.loginUser(
        result.user.uid,
        result.user.displayName,
        result.user.email,
        AUTH_SOURCE.APPLE,
      );
      if (loginSuccess) {
        _stateSubject.add(LoginStateSuccess());
      }
    }
    _stateSubject.add(LoginStateError('Can\'t Sign in!'));
  }
}

enum AUTH_SOURCE { APPLE, GOOGLE, MAIL }
