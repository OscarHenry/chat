import 'package:chat/global/di.dart';
import 'package:chat/global/extensions.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/async_button.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                Logo(title: 'Messenger'),
                LoginForm(),
                Labels(path: 'register'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final SocketService socketService = getIt<SocketService>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController(
        text: context.read<AuthService>().session.user?.email);
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
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
          .logIn(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((userOrNull) {
        if (userOrNull == null) {
          context.showSnackBar(text: 'Login failed');
        } else {
          socketService.connect();
          Navigator.pushReplacementNamed(context, 'user');
        }
      });
    }
  }
}
