import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart'; // Import foundation for @immutable

@immutable // Important for proper state management
sealed class LoginState extends Equatable {
  const LoginState();

  const factory LoginState.unknown() = LoginStateUnknown;
  const factory LoginState.initial() = LoginStateInitial;
  const factory LoginState.loading() = LoginStateLoading;
  const factory LoginState.success() = LoginStateSuccess;
  const factory LoginState.error(String errorMessage) = LoginStateError;

  @override
  List<Object?> get props => []; // Base props for Equatable - error case overrides.
}

class LoginStateUnknown extends LoginState {
  const LoginStateUnknown();
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();
}

class LoginStateUnauthenticated extends LoginState {
  const LoginStateUnauthenticated();
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading();
}

class LoginStateSuccess extends LoginState {
  const LoginStateSuccess();
}

class LoginStateError extends LoginState {
  final String errorMessage;
  const LoginStateError(this.errorMessage);

  LoginStateError copyWith({String? errorMessage}) {
    return LoginStateError(errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [errorMessage]; // Ensure Equatable works correctly for errors
}
