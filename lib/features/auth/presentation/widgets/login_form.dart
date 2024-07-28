


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/auth/auth_bloc.dart';
import 'auth_btn.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //text
          Text(
            "Welcomeback you\'ve been missed",
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'le email est obligatoire'; //dans le dossier Strings
                }
                if (!isEmail(value)) {
                  return "email incorrect";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'le mot de passe est obligatoire'; //!! dans Strings
                }
                return null;
              },
              controller: _pwdController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            /* child: ElevatedButton(
              onPressed: validateAndLoginUser,
              child: const Text('Login'),
            ), */
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is LoginProgressState) {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                } else {
                  return AuthButton(
                      text: "Sign In",
                      onPressed: validateAndLoginUser,
                      color: Colors.black);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void validateAndLoginUser() {
    if (_formKey.currentState!.validate()) {
      final user = UserEntity(
          name: "",
          email: _emailController.text.trim(),
          password: _pwdController.text.trim());

      BlocProvider.of<AuthBloc>(context).add(LoginEvent(user: user));
    }
  }
}