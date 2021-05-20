import 'dart:async';

import 'package:bloc_example/features/todo/model/todo.dart';
import 'package:bloc_example/features/todo/todoRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//State
@immutable
abstract class TodoAddState {}

class TodoAddIntial extends TodoAddState {}

class TodoAddInProgress extends TodoAddState {}

class TodoAddFailure extends TodoAddState {
  final String errorMessage;

  TodoAddFailure(this.errorMessage);
}

class TodoAddSuccess extends TodoAddState {
  final Todo todo;

  TodoAddSuccess(this.todo);
}

class TodoAddCubit extends Cubit<TodoAddState> {
  final TodoRepository _todoRepository;
  TodoAddCubit(this._todoRepository) : super(TodoAddIntial());

  Future<void> addTodo(String title) async {
    try {
      emit(TodoAddInProgress());
      emit(TodoAddSuccess(await _todoRepository.addTodo(title)));
    } catch (e) {
      emit(TodoAddFailure(e.toString()));
    }
  }
}
