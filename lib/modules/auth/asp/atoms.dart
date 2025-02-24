import 'package:adm_botecaria/modules/auth/providers/states/forgot_password_states.dart';
import 'package:asp/asp.dart';
import '../providers/states/login_states.dart';

final loginStateAtom = atom<LoginState>(LoginStateInitial());

final passwordStateAtom = atom<ForgotPasswordState>(ForgotPasswordInitial());

// Login fields
final loginEmailAtom = atom<String>('');
final loginPasswordAtom = atom<String?>('');
