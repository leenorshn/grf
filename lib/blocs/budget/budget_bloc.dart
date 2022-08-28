import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grf/apis/budget_api.dart';
import 'package:grf/models/budget.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetApi budgetApi;
  StreamSubscription? subscription;
  BudgetBloc(this.budgetApi) : super(BudgetInitial()) {
    on<BudgetEvent>((event, emit) async {
      if (event is LoadBudgetEvent) {
        emit(BudgetIsLoading());
        try {
          subscription = budgetApi
              .getOne()
              .listen((event) => add(UpdateBudgetEvent(event)));
        } on Exception {
          emit(BudgetLoadedFailure());
        }
      }

      if (event is UpdateBudgetEvent) {
        emit(BudgetLoadedSuccess(event.data));
      }
      if (event is AddBudgetEvent) {
        await budgetApi.addBudget(event.budget);
      }
    });
  }
}
