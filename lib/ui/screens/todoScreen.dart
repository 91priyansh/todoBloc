import 'package:bloc_example/features/todo/cubit/todoCubit.dart';
import 'package:bloc_example/features/todo/cubit/todoDeleteCubit.dart';
import 'package:bloc_example/features/todo/cubit/todoUpdateCubit.dart';
import 'package:bloc_example/features/todo/model/todo.dart';
import 'package:bloc_example/features/todo/todoRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatefulWidget {
  final Todo todo;
  const TodoScreen({Key key, this.todo}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();

  static Route<TodoScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => TodoScreen(
              todo: routeSettings.arguments,
            ));
  }
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController _textEditingController;
  Todo _todo;

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.todo.title);
    _todo = widget.todo;
    super.initState();
  }

  Widget _buildUpdateButton(BuildContext context) {
    return BlocConsumer<TodoUpdateCubit, TodoUpdateState>(
        bloc: context.read<TodoUpdateCubit>(),
        builder: (context, state) {
          if (state is TodoUpdateInProgress) {
            return ElevatedButton(
                onPressed: () {},
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ));
          }
          return ElevatedButton(
              onPressed: () {
                context.read<TodoUpdateCubit>().updateTodo(
                    _todo.copyWith(title: _textEditingController.text.trim()));
              },
              child: Text("Update"));
        },
        listener: (context, state) {
          if (state is TodoUpdateSuccess) {
            showSnackBar(context, "Todo updated successfully");
            //update Todo list
            context.read<TodoCubit>().updateTodoList(state.todo, "todoUpdated");
          } else if (state is TodoUpdateFailure) {
            showSnackBar(context, state.errorMessage);
          }
        });
  }

  Widget _buildDeleteButton(BuildContext context) {
    return BlocConsumer<TodoDeleteCubit, TodoDeleteState>(
        bloc: context.read<TodoDeleteCubit>(),
        builder: (context, state) {
          if (state is TodoDeleteInProgress) {
            return ElevatedButton(
                onPressed: () {},
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ));
          }
          return ElevatedButton(
              onPressed: () {
                context.read<TodoDeleteCubit>().deleteTodo(_todo.id);
              },
              child: Text("Delete"));
        },
        listener: (context, state) {
          if (state is TodoDeleteSuccess) {
            //update Todo list
            context
                .read<TodoCubit>()
                .updateTodoList(widget.todo, "todoDeleted");
            Navigator.of(context).pop();
          } else if (state is TodoDeleteFailure) {
            showSnackBar(context, state.errorMessage);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoUpdateCubit>(
            create: (context) => TodoUpdateCubit(TodoRepository())),
        BlocProvider<TodoDeleteCubit>(
            create: (context) => TodoDeleteCubit(TodoRepository())),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Todo"),
          ),
          body: Column(
            children: [
              TextField(
                controller: _textEditingController,
              ),
              SizedBox(
                height: 50.0,
              ),
              SwitchListTile(
                value: _todo.isCompleted,
                onChanged: (value) {
                  setState(() {
                    _todo = _todo.copyWith(isCompleted: value);
                  });
                },
                title: Text("Completed"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildUpdateButton(context),
                  _buildDeleteButton(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
