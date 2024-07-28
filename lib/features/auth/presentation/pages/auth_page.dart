import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../widgets/auth_btn.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to reports application",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthButton(
                    text: "Login",
                    onPressed: () {
                      GoRouter.of(context).pushNamed('login');
                    },
                    color: Colors.black),
                const SizedBox(
                  height: 20,
                ),
                AuthButton(
                    text: "Register",
                    onPressed: () {
                      GoRouter.of(context).goNamed("register");
                    },
                    color: Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
