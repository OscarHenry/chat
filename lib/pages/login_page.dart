import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
                Labels(
                  path: 'register'
                ),
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
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(48.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomInput(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8.0),
              CustomInput(
                controller: passwordController,
                hintText: 'Password',
                prefixIcon: const Icon(Icons.password),
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(height: 18.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
