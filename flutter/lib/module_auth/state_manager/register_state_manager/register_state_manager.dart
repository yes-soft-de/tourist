import 'package:tourists/module_auth/enums/auth_status.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:tourists/module_auth/ui/states/register_states/register_state.dart';
import 'package:tourists/module_auth/ui/states/register_states/register_state_code_sent.dart';
import 'package:tourists/module_auth/ui/states/register_states/register_state_error.dart';
import 'package:tourists/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:tourists/module_auth/ui/states/register_states/register_state_success.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class RegisterStateManager {
  final AuthService _authService;
  final _registerStateSubject = PublishSubject<RegisterState>();

  RegisterStateManager(this._authService);

  Stream<RegisterState> get stateStream => _registerStateSubject.stream;

  void registerCaptain(
      String phoneNumber, RegisterScreenState _registerScreenState) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          break;
        case AuthStatus.CODE_SENT:
          _registerStateSubject
              .add(RegisterStatePhoneCodeSent(_registerScreenState));
          break;
        case AuthStatus.CODE_TIMEOUT:
          _registerStateSubject
              .add(RegisterStateError(_registerScreenState, 'Code Timeout'));
          break;
        default:
          _registerStateSubject.add(RegisterStateInit(_registerScreenState));
          break;
      }
    }).onError((err) {
      _registerStateSubject
          .add(RegisterStateError(_registerScreenState, err.toString()));
    });

    _authService.verifyWithPhone(true, phoneNumber, UserRole.ROLE_GUIDE);
  }

  void registerOwner(String email, String name, String password,
      RegisterScreenState registerScreenState) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _registerStateSubject.add(RegisterStateSuccess(registerScreenState));
          break;
        default:
          _registerStateSubject.add(RegisterStateInit(registerScreenState));
          break;
      }
    }).onError((err) {
      _registerStateSubject
          .add(RegisterStateError(registerScreenState, err.toString()));
    });

    _authService.registerWithEmailAndPassword(
        email, password, name, UserRole.ROLE_TOURIST);
  }

  void confirmCaptainCode(String smsCode) {
    _authService.confirmWithCode(smsCode, UserRole.ROLE_GUIDE, true);
  }
}
