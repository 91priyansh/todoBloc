import 'dart:async';

import 'package:bloc_example/features/todo/todoRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//State
@immutable
abstract class TodoDeleteState {}

class TodoDeleteIntial extends TodoDeleteState {}

class TodoDeleteInProgress extends TodoDeleteState {}

class TodoDeleteFailure extends TodoDeleteState {
  final String errorMessage;

  TodoDeleteFailure(this.errorMessage);
}

class TodoDeleteSuccess extends TodoDeleteState {
  final String todoId;

  TodoDeleteSuccess(this.todoId);
}

class TodoDeleteCubit extends Cubit<TodoDeleteState> {
  final TodoRepository _todoRepository;
  TodoDeleteCubit(this._todoRepository) : super(TodoDeleteIntial());

  Future<void> deleteTodo(String todoId) async {
    try {
      emit(TodoDeleteInProgress());
      emit(TodoDeleteSuccess(await _todoRepository.deleteTodo(todoId)));
    } catch (e) {
      emit(TodoDeleteFailure(e.toString()));
    }
  }
}
