import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../bloc/user_manager/user_manager_bloc.dart';
import 'auth_btn.dart';


class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'name is necessary';
                  }
                  return null;
                },
                controller: _nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is necessary';
                  }
                  if (!isEmail(value)) {
                    return "incorrect email";
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
                    return 'the password is necessary';
                  }
                  if (!isLength(value, 8)) {
                    return "you need a stronger password";
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
                  hintText: 'Passsword',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              /* child: ElevatedButton(
                onPressed: validateAndRegisterUser,
                child: const Text('Submit'),
              ), */
              child: BlocBuilder<UserManagerBloc, UserManagerState>(
                builder: (context, state) {
                  if (state is RegisteringUserState) {
                    return const CircularProgressIndicator(color: Colors.black);
                  } else {
                    return AuthButton(
                        text: "Register",
                        onPressed: validateAndRegisterUser,
                        color: Colors.black);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateAndRegisterUser() {
    if (_formKey.currentState!.validate()) {
      final user = UserEntity(
          name: _nameController.text,
          email: _emailController.text,
          password: _pwdController.text);

      BlocProvider.of<UserManagerBloc>(context).add(RegisterEvent(user: user));
    }
  }
}
