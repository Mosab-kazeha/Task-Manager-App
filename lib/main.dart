import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/config/get_it.dart';
import 'package:task_manager_app/config/observer.dart';
import 'package:task_manager_app/screen/login_screen.dart';
import 'package:task_manager_app/screen/todo_screen.dart';
import 'package:task_manager_app/state_management/cheaking_token_bloc/cheaking_token_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  setup(); //? we init the FlutterSecureStorage

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CheakingTokenBloc()..add(CheakingToken()),
        child: BlocBuilder<CheakingTokenBloc, CheakingTokenState>(
          builder: (context, state) {
            if (state is TokenNotExisted) {
              return LoginScreen();
            } else {
              return TasksScreen();
            }
          },
        ),
      ),
    );
  }
}
