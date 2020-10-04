import 'dart:developer';

import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class GuideLoginBloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const int STATUS_CODE_INIT = -1;
  static const int STATUS_CODE_SENT = 1;
  static const int STATUS_CODE_RECEIVED = 2;
  static const int STATUS_CODE_FAILED = 3;
  static const int STATUS_CODE_CONFIRM_ERROR = 4;

  String _verificationId;

  final PublishSubject<Pair<int, dynamic>> _stateSubject = new PublishSubject();

  Stream<Pair<int, dynamic>> get stateStream => _stateSubject.stream;

  void login(String phoneNumber) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 30),
        verificationCompleted: (AuthCredential credentials) {
          log('Verification Complete');
          _auth.signInWithCredential(credentials).then((result) {
            User user = result.user;

            if (user != null) {
              log('Code Verify complete');
              _stateSubject.add(Pair(STATUS_CODE_RECEIVED, user));
            } else {
              _stateSubject.add(Pair(STATUS_CODE_CONFIRM_ERROR, null));
              print('Error');
            }
          });
        },
        verificationFailed: (err) {
          log('Verification Failed: ' + err.message);
          _stateSubject.add(Pair(STATUS_CODE_FAILED, err.message));
          Fluttertoast.showToast(msg: err.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          log('Code Sent: ' + verificationId);
          _verificationId = verificationId;
          _stateSubject.add(Pair(STATUS_CODE_SENT, null));
        },
        codeAutoRetrievalTimeout: null);
  }

  void confirmCode(String code) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: code);

    UserCredential result = await _auth.signInWithCredential(credential);

    User user = result.user;

    if (user != null) {
      log('Code Verify complete');
      _stateSubject.add(Pair(STATUS_CODE_RECEIVED, user));
    } else {
      _stateSubject.add(Pair(STATUS_CODE_CONFIRM_ERROR, null));
      print('Error');
    }
  }
}
