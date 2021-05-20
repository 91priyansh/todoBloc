import 'package:bloc_example/features/todo/cubit/todoAddCubit.dart';
import 'package:bloc_example/features/todo/cubit/todoCubit.dart';
import 'package:bloc_example/features/todo/todoRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key key}) : super(key: key);

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoAddCubit>(
      create: (_) => TodoAddCubit(TodoRepository()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Add todo"),
            ),
            body: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: "Enter todo title"),
            ),
            floatingActionButton: BlocConsumer<TodoAddCubit, TodoAddState>(
                bloc: context.read<TodoAddCubit>(),
                builder: (context, state) {
                  return FloatingActionButton(
                    onPressed: state is TodoAddInProgress
                        ? () {}
                        : () {
                            context
                                .read<TodoAddCubit>()
                                .addTodo(_textEditingController.text.trim());
                          },
                    child: state is TodoAddInProgress
                        ? CircularProgressIndicator(color: Colors.white)
                        : Icon(Icons.add),
                  );
                },
                listener: (context, state) {
                  if (state is TodoAddSuccess) {
                    //show todo added message
                    showSnackBar(context, "Todo added successfully");
                    //update todoList of TodoCubit
                    context
                        .read<TodoCubit>()
                        .updateTodoList(state.todo, "todoAdded");
                  } else if (state is TodoAddFailure) {
                    showSnackBar(context, state.errorMessage);
                  }
                }),
          );
        },
      ),
    );
  }
}
