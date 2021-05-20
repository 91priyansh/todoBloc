import 'package:bloc_example/features/todo/model/todo.dart';
import 'package:bloc_example/features/todo/todoLocalDataSource.dart';
import 'package:uuid/uuid.dart';

class TodoRepository {
  TodoLocalDatasource _todoLocalDatasource;

  static final TodoRepository _todoRepository = TodoRepository._internal();

  factory TodoRepository() {
    _todoRepository._todoLocalDatasource = TodoLocalDatasource();
    return _todoRepository;
  }

  TodoRepository._internal();

  Future<List<Todo>> fetchTodos() async {
    try {
      final todos = await _todoLocalDatasource.getTodos();
      //sort if need or any other things
      return todos.map((todo) => Todo.fromJson(todo)).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<Todo> addTodo(String title) async {
    try {
      final Todo todo = Todo(
          id: Uuid().v4(),
          isCompleted: false,
          timestamp: DateTime.now().toString(),
          title: title);

      await _todoLocalDatasource.addTodo(todo);

      return todo;
    } catch (e) {
      throw e;
    }
  }

  Future<Todo> updateTodo(Todo updatedTodo) async {
    try {
      await _todoLocalDatasource.updateTodo(updatedTodo);
      return updatedTodo;
    } catch (e) {
      throw e;
    }
  }

  Future<String> deleteTodo(String todoId) async {
    try {
      await _todoLocalDatasource.deleteTodo(todoId);
      return todoId;
    } catch (e) {
      throw e;
    }
  }
}
