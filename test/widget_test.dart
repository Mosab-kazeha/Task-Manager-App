import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/model/auth/login_request_model.dart';
import 'package:task_manager_app/state_management/login_bloc/login_bloc.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  late LoginBloc loginBloc;
  late TextEditingController userNameController;
  late TextEditingController passwordController;

  setUp(() {
    loginBloc = MockLoginBloc();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  });

  tearDown(() {
    userNameController.dispose();
    passwordController.dispose();
  });

  testWidgets('should display SizedBox with correct height', (tester) async {
    const height = 1000.0;
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(height: height / 10),
        ),
      ),
    );

    final sizedBox = find.byType(SizedBox);
    expect(sizedBox, findsOneWidget);
    expect(
      find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.height == height / 10),
      findsOneWidget,
    );
  });

  testWidgets(
      'should call LoginBloc.add() when both username and password are not empty',
      (tester) async {
    userNameController.text = 'kminchelle';
    passwordController.text = '0lelplR';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InkWell(
            onTap: () {
              if (userNameController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                loginBloc.add(LoginUser(
                  userData: LoginRequestModel(
                    username: userNameController.text,
                    password: passwordController.text,
                  ),
                ));
              }
            },
            child: Container(),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    verify(loginBloc.add(LoginUser(
            userData: LoginRequestModel(
                username: userNameController.text,
                password: passwordController.text))))
        .called(1);
  });

  testWidgets('should show SnackBar when either username or password is empty',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InkWell(
            onTap: () {
              if (userNameController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                ScaffoldMessenger.of(tester.element(find.byType(Scaffold)))
                    .showSnackBar(const SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text('you need to Enter your name and password'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            child: Container(),
          ),
        ),
      ),
    );

    userNameController.text = '';
    passwordController.text = 'testpassword';
    await tester.tap(find.byType(InkWell));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);

    userNameController.text = 'testuser';
    passwordController.text = '';
    await tester.tap(find.byType(InkWell));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
