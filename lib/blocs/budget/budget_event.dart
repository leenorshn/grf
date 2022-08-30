part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class LoadBudgetEvent extends BudgetEvent {}

class UpdateBudgetEvent extends BudgetEvent {
  final List<Budget> data;

  const UpdateBudgetEvent(this.data);
}

class AddBudgetEvent extends BudgetEvent {
  final Budget budget;

  const AddBudgetEvent(this.budget);
}

class RemoveBudgetEvent extends BudgetEvent {
  final String id;

  const RemoveBudgetEvent(this.id);
}
