import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
  late final TextEditingController nameController = TextEditingController();
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
                controller: nameController,
                hintText: 'Name',
                prefixIcon: const Icon(Icons.person_2_outlined),
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8.0),
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
