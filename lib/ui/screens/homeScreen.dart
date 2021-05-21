import 'package:bloc_example/features/todo/cubit/todoCubit.dart';
import 'package:bloc_example/features/todo/model/todo.dart';
import 'package:bloc_example/ui/styles/colors.dart';
import 'package:bloc_example/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => context.read<TodoCubit>().fetchTodo());
  }

  Widget _buildTodoList(List<Todo> todos) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Todo todo = todos[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.todo, arguments: todo);
          },
          title: Text(todo.title),
          trailing: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: todo.isCompleted ? completedColor : incompletedColor),
          ),
        );
      },
      itemCount: todos.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App Bloc"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.settings);
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
          bloc: context.read<TodoCubit>(),
          builder: (context, state) {
            if (state is TodoFetchInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TodoFetchFailure) {
              return Center(
                child: Text(
                  state.errorMessage,
                ),
              );
            }
            return _buildTodoList((state as TodoFetchSuccess).todos);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("object");
          print(Theme.of(context).primaryColor.toString());
          //Navigator.of(context).pushNamed(Routes.addTodo);
        },
      ),
    );
  }
}
