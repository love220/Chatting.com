import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/components/my_button.dart';
import 'package:socialapp/components/my_textfield.dart';
import 'package:socialapp/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // login method
  void login() async {
    // show a loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Try sign in

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // pop the loading circle

      // ignore: use_build_context_synchronously
      if (context.mounted) Navigator.pop(context);
    }
    // display errors
    on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo

              Icon(
                Icons.person,
                size: 32,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 20),

              // app name

              Text(
                'P A L L E T E   S T U D I O S ●',
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 20),
              // email textfield

              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
              ),

              const SizedBox(height: 10),
              // password
              MyTextField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),

              const SizedBox(height: 10),
              // forgot password

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // sign in button
              MyButton(
                text: 'LogIn',
                onTap: login,
              ),

              const SizedBox(height: 20),
              // don't have an account? Register

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Register Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
