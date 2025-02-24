import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  const factory ForgotPasswordState.initial() = ForgotPasswordInitial;
  const factory ForgotPasswordState.loading() = ForgotPasswordLoading;
  const factory ForgotPasswordState.sent() = ForgotPasswordSent;
  const factory ForgotPasswordState.error(String message) = ForgotPasswordError;

  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

class ForgotPasswordSent extends ForgotPasswordState {
  const ForgotPasswordSent();
}

class ForgotPasswordError extends ForgotPasswordState {
  final String errorMessage;
  const ForgotPasswordError(this.errorMessage);

  ForgotPasswordError copyWith({String? errorMessage}) {
    return ForgotPasswordError(errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [errorMessage];
}
