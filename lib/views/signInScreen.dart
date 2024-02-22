// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter/views/forgotPasswordScreen.dart';
import 'package:note_app_flutter/views/homeScreen.dart';
import 'package:note_app_flutter/views/signUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Login Screen"),
        // actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 250,
                child: Lottie.asset("assets/Animation - 1708493774305.json"),
              ),
              const SizedBox(height: 50.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginEmailController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginPasswordController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: Icon(Icons.visibility),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                  onPressed: () async {
                    var loginEmail = loginEmailController.text.trim();
                    var loginPassword = loginPasswordController.text.trim();

                    try {
                      final User? firebaseUser = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: loginEmail, password: loginPassword))
                          .user;
                      if (firebaseUser != null) {
                        Get.to(() => const HomeScreen());
                      } else {
                        print("Check Email & Password");
                      }
                    } on FirebaseAuthException catch (e) {
                      print("Error $e");
                    }
                  },
                  child: const Text("Login")),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ForgotPasswordScreen());
                },
                child: Container(
                  child: const Card(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Forgot Password"),
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SignUpScreen());
                },
                child: Container(
                  child: const Card(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Don't have an account SignUp"),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
