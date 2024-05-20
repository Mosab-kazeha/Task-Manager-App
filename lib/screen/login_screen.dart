

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/auth/login_request_model.dart';
import '../state_management/login_bloc/login_bloc.dart';
import 'todo_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    double? width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Builder(builder: (context) {
        return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessfully) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 10),
                content: Text('Login Successfully'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TasksScreen(),
                ),
              );
            } else if (state is ErrorInLogin) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 10),
                content: Text('Please Check Your Name and Password'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ));
            } else if (state is ExceptionInLogin) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 10),
                content: Text('There is no internet'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ));
            }
          },
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: width / 5, bottom: width / 7),
                      child: Text(
                        'Task\nManager',
                        style: TextStyle(
                          color: const Color(0xFF8AA7B4),
                          fontSize: height / 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: width / 1.2,
                        height: height / 13,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF5F4F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: TextField(
                          controller: userNameController,
                          decoration: InputDecoration(
                              hintText: 'Enter Your Name',
                              hintStyle: const TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 18,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: width / 1.2,
                        height: height / 13,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF5F4F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: 'Enter Your Password',
                              hintStyle: const TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 18,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 10),
                    InkWell(
                      onTap: () {
                        if (userNameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          context.read<LoginBloc>().add(LoginUser(
                                  userData: LoginRequestModel(
                                username: userNameController.text,
                                password: passwordController.text,
                              )));
                        }
                        if (userNameController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 10),
                            content: Text(
                                'you need to Enter your name and password'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      },
                      child: Container(
                        width: width / 1.2,
                        height: height / 13,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF8AA7B4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'create task',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
