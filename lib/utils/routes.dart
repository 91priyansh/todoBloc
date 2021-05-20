import 'package:bloc_example/ui/screens/addTodoScreen.dart';
import 'package:bloc_example/ui/screens/homeScreen.dart';
import 'package:bloc_example/ui/screens/todoScreen.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static const home = "/";
  static const addTodo = "/addTodo";
  static const todo = "/todo";

  static Route<dynamic> onGenerateRouted(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
      case addTodo:
        return CupertinoPageRoute(builder: (context) => AddTodoScreen());
      case todo:
        return TodoScreen.route(routeSettings);

      default:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
    }
  }
}
