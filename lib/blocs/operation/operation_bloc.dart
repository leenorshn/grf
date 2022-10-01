import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grf/apis/operation_api.dart';
import 'package:grf/models/operation.dart';

part 'operation_event.dart';
part 'operation_state.dart';

class OperationBloc extends Bloc<OperationEvent, OperationState> {
  final OperationApi operationApi;
  StreamSubscription? subscription;
  OperationBloc(this.operationApi) : super(OperationInitial()) {
    on<OperationEvent>((event, emit) async {
      if (event is LoadOpsEvent) {
        try {
          emit(OperationIsLoading());
          subscription = operationApi
              .getAll()
              .listen((event) => add(UpdateOpsEvent(event)));
        } on Exception {
          emit(OperationLoadedFailure());
        }
      }

      if (event is UpdateOpsEvent) {
        //print(event.data[1].type);
        emit(OperationLoadedSuccess(event.data));
      }
      if (event is AddOpsEvent) {
        await operationApi.addBudget(event.operation);
        add(LoadOpsEvent());
      }
    });
  }
}
