import 'package:adm_botecaria/modules/auth/providers/states/forgot_password_states.dart';
import 'package:asp/asp.dart';
import '../../../setup_locator.dart';
import '../providers/states/login_states.dart';
import '../repository/auth_repository.dart';
import '../services/auth_service.dart';
import 'atoms.dart';

final setLoginEmailAction = atomAction1<String>((set, email) {
  set(loginEmailAtom, email);
});
final setLoginPasswordAction = atomAction1<String>((set, password) {
  set(loginPasswordAtom, password);
});

final loginAction = atomAction((set) async {
  set(loginStateAtom, LoginStateLoading());

  final AuthRepository authRepository = AuthRepository(getIt<AuthService>());

  try {
    await authRepository.login(
      loginEmailAtom.state.trim(),
      loginPasswordAtom.state!.trim(),
    );
    set(loginStateAtom, LoginStateSuccess());
  } catch (e) {
    set(loginStateAtom, LoginStateError(e.toString()));
  }
});

final logoutAction = atomAction((set) async {
  final AuthRepository authRepository = AuthRepository(getIt<AuthService>());

  await authRepository.logout();
  set(loginStateAtom, LoginStateInitial());
});

final setLoginStateSuccessAction = atomAction((set) async {
  set(loginStateAtom, LoginStateSuccess());
});
final setLoginStateInitialAction = atomAction((set) async {
  set(loginStateAtom, LoginStateInitial());
});

final forgotPasswordAction = atomAction1<String>((set, email) async {
  set(passwordStateAtom, ForgotPasswordLoading());

  final AuthRepository authRepository = AuthRepository(getIt<AuthService>());

  try {
    await authRepository.forgotPassword(email);
    set(passwordStateAtom, ForgotPasswordSent());
  } catch (e) {
    set(passwordStateAtom, ForgotPasswordError(e.toString()));
  }
});

final setInitialForgotPasswordAction = atomAction((set) async {
  set(loginStateAtom, ForgotPasswordInitial());
});
