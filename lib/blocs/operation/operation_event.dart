part of 'operation_bloc.dart';

abstract class OperationEvent extends Equatable {
  const OperationEvent();

  @override
  List<Object> get props => [];
}

class LoadOpsEvent extends OperationEvent {}

class UpdateOpsEvent extends OperationEvent {
  final List<Operation> data;

  const UpdateOpsEvent(this.data);
}

class AddOpsEvent extends OperationEvent {
  final Operation operation;

  const AddOpsEvent(this.operation);
}
