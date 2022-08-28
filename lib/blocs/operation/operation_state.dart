part of 'operation_bloc.dart';

abstract class OperationState extends Equatable {
  const OperationState();

  @override
  List<Object> get props => [];
}

class OperationInitial extends OperationState {
  @override
  List<Object> get props => [];
}

class OperationLoadedSuccess extends OperationState {
  final List<Operation> data;

  const OperationLoadedSuccess(this.data);
}

class OperationLoadedFailure extends OperationState {}

class OperationIsLoading extends OperationState {}
