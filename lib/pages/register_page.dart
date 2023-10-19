import 'package:chat/global/di.dart';
import 'package:chat/global/extensions.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/async_button.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(title: 'Register'),
                RegisterForm(),
                Labels(path: 'login'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final SocketService socketService = getIt<SocketService>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(48.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomInput(
                controller: nameController,
                hintText: 'Name',
                prefixIcon: const Icon(Icons.person_2_outlined),
                textInputType: TextInputType.name,
                validator: nameValidator,
              ),
              const SizedBox(height: 8.0),
              CustomInput(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                textInputType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              const SizedBox(height: 8.0),
              CustomInput(
                controller: passwordController,
                hintText: 'Password',
                prefixIcon: const Icon(Icons.password),
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
                validator: passwordValidator,
              ),
              const SizedBox(height: 18.0),
              AsyncButton(
                onPressed: submit,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length <= 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  Future<void> submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      _formKey.currentState?.save();
      await context
          .read<AuthService>()
          .signIn(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          )
          .then((userOrNull) {
        if (userOrNull == null) {
          context.showSnackBar(text: 'Register failed');
        } else {
          socketService.connect();
          Navigator.pushReplacementNamed(context, 'user');
        }
      });
    }
  }
}
