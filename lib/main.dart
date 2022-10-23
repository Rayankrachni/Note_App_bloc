import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/bloc/note_cubit.dart';
import 'package:untitled5/presentation/home_screen/HomeScreen.dart';

import 'core/style/themestyle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp

  ({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeServices().lightTheme,
        darkTheme: ThemeServices().darkTheme,
        themeMode: ThemeServices().getThemeMode(),
        home: const HomeScreen(),
      ),
    );
  }
}


