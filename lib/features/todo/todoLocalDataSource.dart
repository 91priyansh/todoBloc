import 'package:bloc_example/features/todo/model/todo.dart';
import 'package:bloc_example/utils/constants.dart';
import 'package:bloc_example/utils/customException.dart';
import 'package:hive/hive.dart';

class TodoLocalDatasource {
  bool isBoxOpened() {
    return Hive.isBoxOpen(todoBox);
  }

  Future<void> openTodosBox() async {
    if (!isBoxOpened()) {
      await Hive.openBox(todoBox);
    }
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    await openTodosBox();
    final todosBox = Hive.box(todoBox);
    final List<Map<String, dynamic>> todos = [];
    todosBox.keys.forEach((key) {
      todos.add(Map<String, dynamic>.from(todosBox.get(key)));
    });
    return todos;
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await openTodosBox();
      final todosBox = Hive.box(todoBox);
      await todosBox.put(todo.id, Todo.toJson(todo));
    } catch (_) {
      throw CustomException(errorMessage: "Failed to add todo");
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await openTodosBox();
      final todosBox = Hive.box(todoBox);
      await todosBox.put(todo.id, Todo.toJson(todo));
    } catch (_) {
      throw CustomException(errorMessage: "Failed to update todo");
    }
  }

  Future<void> deleteTodo(String todoId) async {
    try {
      await openTodosBox();
      final todosBox = Hive.box(todoBox);
      await todosBox.delete(todoId);
    } catch (_) {
      throw CustomException(errorMessage: "Failed to delete todo");
    }
  }
}
