import 'dart:async';

import 'package:bloc_example/features/todo/model/todo.dart';
import 'package:bloc_example/features/todo/todoRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//State
@immutable
abstract class TodoUpdateState {}

class TodoUpdateIntial extends TodoUpdateState {}

class TodoUpdateInProgress extends TodoUpdateState {}

class TodoUpdateFailure extends TodoUpdateState {
  final String errorMessage;

  TodoUpdateFailure(this.errorMessage);
}

class TodoUpdateSuccess extends TodoUpdateState {
  final Todo todo;

  TodoUpdateSuccess(this.todo);
}

class TodoUpdateCubit extends Cubit<TodoUpdateState> {
  final TodoRepository _todoRepository;
  TodoUpdateCubit(this._todoRepository) : super(TodoUpdateIntial());

  Future<void> updateTodo(Todo updatedTodo) async {
    try {
      emit(TodoUpdateInProgress());
      emit(TodoUpdateSuccess(await _todoRepository.updateTodo(updatedTodo)));
    } catch (e) {
      emit(TodoUpdateFailure(e.toString()));
    }
  }
}
