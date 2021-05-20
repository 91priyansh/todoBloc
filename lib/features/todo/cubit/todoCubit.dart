import 'dart:async';

import 'package:bloc_example/features/todo/model/todo.dart';
import 'package:bloc_example/features/todo/todoRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//State
@immutable
abstract class TodoState {}

class TodoFetchInProgress extends TodoState {}

class TodoFetchFailure extends TodoState {
  final String errorMessage;

  TodoFetchFailure(this.errorMessage);
}

class TodoFetchSuccess extends TodoState {
  final List<Todo> todos;

  TodoFetchSuccess(this.todos);
}

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _todoRepository;
  TodoCubit(this._todoRepository) : super(TodoFetchInProgress());

  Future<void> fetchTodo() async {
    try {
      emit(TodoFetchSuccess(await _todoRepository.fetchTodos()));
    } catch (e) {
      emit(TodoFetchFailure(e.toString()));
    }
  }

  void updateTodoList(Todo todo, String event) {
    if (state is TodoFetchSuccess) {
      if (event == "todoAdded") {
        final updatedTodoList =
            List<Todo>.from((state as TodoFetchSuccess).todos)..insert(0, todo);
        emit(TodoFetchSuccess(updatedTodoList));
      } else if (event == "todoUpdated") {
        final int index = (state as TodoFetchSuccess)
            .todos
            .indexWhere((element) => element.id == todo.id);
        List<Todo> updatedTodoList =
            List.from((state as TodoFetchSuccess).todos);
        updatedTodoList[index] = todo;
        emit(TodoFetchSuccess(updatedTodoList));
      } else {
        final updatedTodoList =
            List<Todo>.from((state as TodoFetchSuccess).todos)
              ..removeWhere((element) => element.id == todo.id);
        emit(TodoFetchSuccess(updatedTodoList));
      }
    }
  }
}
