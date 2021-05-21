import 'package:bloc_example/app/appConfig.dart';
import 'package:bloc_example/app/locator.dart';
import 'package:bloc_example/features/auth/authRepository.dart';
import 'package:bloc_example/features/auth/cubit/authCubit.dart';
import 'package:bloc_example/features/todo/cubit/todoCubit.dart';
import 'package:bloc_example/features/todo/todoRepository.dart';
import 'package:bloc_example/ui/styles/theme/appTheme.dart';
import 'package:bloc_example/ui/styles/theme/themeCubit.dart';
import 'package:bloc_example/utils/constants.dart';
import 'package:bloc_example/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<Widget> initializeApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  setup(appConfig);
  await Hive.initFlutter();
  await Hive.openBox(
      authBox); //auth box for storing all authentication related details
  await Hive.openBox(
      settingsBox); //settings box for storing all settings details

  return MyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>(create: (_) => TodoCubit(TodoRepository())),
        BlocProvider<AuthCubit>(create: (_) => AuthCubit(AuthRepository())),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: Builder(
        builder: (context) {
          final currentTheme = context.watch<ThemeCubit>().state.appTheme;

          return MaterialApp(
            theme: appThemeData[currentTheme],
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.home,
            onGenerateRoute: Routes.onGenerateRouted,
          );
        },
      ),
    );
  }
}
