import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/utils/snack_bar_message.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/login_form.dart';
import '../widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          GoRouter.of(context).goNamed('thoughts');
        } else if (state is AuthErrorState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  //logo
                  const Logo(),
                  const SizedBox(height: 50),
                  //login form
                  LoginForm(),
                ],
              ),
            )),
      ),
    );
  }
}
