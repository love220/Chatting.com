import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/components/my_button.dart';
import 'package:socialapp/components/my_textfield.dart';
import 'package:socialapp/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // register method
  void register() async {
    //   show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //   make sure the passwords match
    if (passwordController.text != confirmPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);

      //   show error message
      displayMessageToUser("Passwords don't match", context);
    }

    // if passwords do not match

    else {
      // try creating the user
      try {
        // create the user

        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // create a user document and add to firestore

        createUserDocument(userCredential);

        // pop creating the user

        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading the circle
        Navigator.pop(context);

        // diplay error message to the user
        displayMessageToUser(e.code, context);
      }
    }
  }

  // create a user document and collect them in firestore

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
      });
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

              // Icon(
              //   Icons.person,
              //   size: 32,
              //   color: Theme.of(context).colorScheme.inversePrimary,
              // ),

              // const SizedBox(height: 20),

              // app name

              Text(
                'P A L L E T E   S T U D I O S ●',
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 20),
              // email textfield

              // MyTextField(
              //   hintText: 'Username',
              //   obscureText: false,
              //   controller: usernameController,
              // ),
              // const SizedBox(height: 10),

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
              MyTextField(
                hintText: 'Confirm password',
                obscureText: true,
                controller: confirmPasswordController,
              ),

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
                text: 'Register',
                onTap: register,
              ),

              const SizedBox(height: 15),
              // don't have an account? Register

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here",
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
