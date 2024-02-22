// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter/views/signInScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgorPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Forgot Password Screen"),
        // actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 200,
                child: Lottie.asset("assets/Animation - 1708514490377.json"),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: forgorPasswordController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                  onPressed: () {
                    var forgotEmail = forgorPasswordController.text.trim();
                    try {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: forgotEmail)
                          .then((value) => {
                                print("Email send"),
                                Get.off(() => const LoginScreen()),
                              });
                    } on FirebaseAuthException catch (e) {
                      print("Error $e");
                    }
                  },
                  child: const Text("Forgot Password")),
            ],
          ),
        ),
      ),
    );
  }
}
