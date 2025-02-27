import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable // Important for proper state management
sealed class ProductStatusState extends Equatable {
  const ProductStatusState();

  const factory ProductStatusState.initial() = ProductStatusStateInitial;
  const factory ProductStatusState.loading() = ProductStatusStateLoading;
  const factory ProductStatusState.loadingAdding() =
      ProductStatusStateLoadingAdding;
  const factory ProductStatusState.loadingEdit() =
      ProductStatusStateLoadingEdit;
  const factory ProductStatusState.loadingForUpdate() =
      ProductStatusStateLoadingForUpdate;
  const factory ProductStatusState.adding() = ProductStatusStateAdding;
  const factory ProductStatusState.added() = ProductStatusStateAdded;
  const factory ProductStatusState.editing() = ProductStatusStateEditing;
  const factory ProductStatusState.edited(String successEditedMessage) =
      ProductStatusStateEdited;
  const factory ProductStatusState.addingError(String errorMessage) =
      ProductStatusStateAddingError;
  const factory ProductStatusState.editingError(String errorMessage) =
      ProductStatusStateEditingError;
  const factory ProductStatusState.error(String errorMessage) =
      ProductStatusStateError;

  @override
  List<Object?> get props => []; // Base props for Equatable - error case overrides.
}

class ProductStatusStateInitial extends ProductStatusState {
  const ProductStatusStateInitial();
}

class ProductStatusStateUnauthenticated extends ProductStatusState {
  const ProductStatusStateUnauthenticated();
}

class ProductStatusStateLoading extends ProductStatusState {
  const ProductStatusStateLoading();
}

class ProductStatusStateLoadingAdding extends ProductStatusState {
  const ProductStatusStateLoadingAdding();
}

class ProductStatusStateLoadingEdit extends ProductStatusState {
  const ProductStatusStateLoadingEdit();
}

class ProductStatusStateLoadingForUpdate extends ProductStatusState {
  const ProductStatusStateLoadingForUpdate();
}

class ProductStatusStateAdding extends ProductStatusState {
  const ProductStatusStateAdding();
}

class ProductStatusStateAdded extends ProductStatusState {
  const ProductStatusStateAdded();
}

class ProductStatusStateEditing extends ProductStatusState {
  const ProductStatusStateEditing();
}

class ProductStatusStateEdited extends ProductStatusState {
  const ProductStatusStateEdited(this.successEditedMessage);

  final String successEditedMessage;

  ProductStatusStateEdited copyWith({String? successEditedMessage}) {
    return ProductStatusStateEdited(
      successEditedMessage ?? this.successEditedMessage,
    );
  }

  @override
  List<Object?> get props => [successEditedMessage];
}

class ProductStatusStateAddingError extends ProductStatusState {
  final String errorMessage;
  const ProductStatusStateAddingError(this.errorMessage);

  ProductStatusStateAddingError copyWith({String? errorMessage}) {
    return ProductStatusStateAddingError(errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [errorMessage]; // Ensure Equatable works correctly for errors
}

class ProductStatusStateEditingError extends ProductStatusState {
  final String errorMessage;
  const ProductStatusStateEditingError(this.errorMessage);

  ProductStatusStateEditingError copyWith({String? errorMessage}) {
    return ProductStatusStateEditingError(errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [errorMessage]; // Ensure Equatable works correctly for errors
}

class ProductStatusStateError extends ProductStatusState {
  final String errorMessage;
  const ProductStatusStateError(this.errorMessage);

  ProductStatusStateError copyWith({String? errorMessage}) {
    return ProductStatusStateError(errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [errorMessage]; // Ensure Equatable works correctly for errors
}
