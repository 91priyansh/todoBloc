import 'package:bloc_example/ui/styles/theme/appTheme.dart';
import 'package:bloc_example/ui/styles/theme/themeCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          BlocBuilder<ThemeCubit, ThemeState>(
            bloc: context.read<ThemeCubit>(),
            builder: (context, state) {
              return ListTile(
                title: Text("Theme"),
                subtitle: Text(state.appTheme.toString().toLowerCase()),
              );
            },
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().changeTheme(AppTheme.Light);
              },
              child: Text("Light")),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().changeTheme(AppTheme.Dark);
              },
              child: Text("Dark")),
        ],
      ),
    );
  }
}
