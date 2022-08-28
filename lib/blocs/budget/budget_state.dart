part of 'budget_bloc.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();
  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {
  @override
  List<Object> get props => [];
}

class BudgetLoadedSuccess extends BudgetState {
  final List<Budget> data;

  const BudgetLoadedSuccess(this.data);
}

class BudgetLoadedFailure extends BudgetState {}

class BudgetIsLoading extends BudgetState {}
