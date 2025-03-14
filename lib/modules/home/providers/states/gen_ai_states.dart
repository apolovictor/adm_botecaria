import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable // Important for proper state management
sealed class GenAiStates extends Equatable {
  const GenAiStates();

  const factory GenAiStates.initial() = GenAiStatesInitial;
  const factory GenAiStates.searchable() = GenAiStatesSearchable;
  const factory GenAiStates.loading() = GenAiStatesLoading;
  const factory GenAiStates.success() = GenAiStatesSuccess;

  const factory GenAiStates.error(String errorMessage) = GenAiStatesError;

  @override
  List<Object?> get props => [];
}

class GenAiStatesInitial extends GenAiStates {
  const GenAiStatesInitial();
}

class GenAiStatesSearchable extends GenAiStates {
  const GenAiStatesSearchable();
}

class GenAiStatesLoading extends GenAiStates {
  const GenAiStatesLoading();
}

class GenAiStatesSuccess extends GenAiStates {
  const GenAiStatesSuccess();
}

class GenAiStatesError extends GenAiStates {
  final String errorMessage;
  const GenAiStatesError(this.errorMessage);

  GenAiStatesError copyWith({String? errorMessage}) {
    return GenAiStatesError(errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [errorMessage];
}
