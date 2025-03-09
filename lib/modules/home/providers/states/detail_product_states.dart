import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable // Important for proper state management
sealed class DetailProductStates extends Equatable {
  const DetailProductStates();

  const factory DetailProductStates.initial() = DetailProductStatesInitial;
  const factory DetailProductStates.loading() = DetailProductStatesLoading;
  const factory DetailProductStates.success(String successMessage) =
      DetailProductStatesSuccess;

  const factory DetailProductStates.error(String errorMessage) =
      DetailProductStatesError;

  @override
  List<Object?> get props => [];
}

class DetailProductStatesInitial extends DetailProductStates {
  const DetailProductStatesInitial();
}

class DetailProductStatesLoading extends DetailProductStates {
  const DetailProductStatesLoading();
}

class DetailProductStatesSuccess extends DetailProductStates {
  final String successMessage;
  const DetailProductStatesSuccess(this.successMessage);

  DetailProductStatesSuccess copyWith({String? successMessage}) {
    return DetailProductStatesSuccess(successMessage ?? this.successMessage);
  }

  @override
  List<Object?> get props =>
      [successMessage]; // Ensure Equatable works correctly for errors
}

class DetailProductStatesError extends DetailProductStates {
  final String errorMessage;
  const DetailProductStatesError(this.errorMessage);

  DetailProductStatesError copyWith({String? errorMessage}) {
    return DetailProductStatesError(errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [errorMessage]; // Ensure Equatable works correctly for errors
}
