import 'package:bloc_example/features/todo/cubit/todoCubit.dart';
import 'package:bloc_example/features/todo/todoRepository.dart';
import 'package:bloc_example/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(TodoRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        onGenerateRoute: Routes.onGenerateRouted,
      ),
    );
  }
}
