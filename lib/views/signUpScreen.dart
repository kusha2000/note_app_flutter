// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter/services/signUpServices.dart';
import 'package:note_app_flutter/views/signInScreen.dart';
import 'dart:developer';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SignUp Screen"),
        // actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 200,
                child: Lottie.asset("assets/Animation - 1708497028538.json"),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "UserName",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userPhoneController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Phone",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userEmailController,
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
                  controller: userPasswordController,
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
                    var userName = userNameController.text.trim();
                    var userPhone = userPhoneController.text.trim();
                    var userEmail = userEmailController.text.trim();
                    var userPassword = userPasswordController.text.trim();

                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: userEmail, password: userPassword)
                        .then((value) => {
                              log("User Created"),
                              signUpUser(
                                  userName, userPhone, userEmail, userPassword)
                            });
                  },
                  child: const Text("Sign Up")),
              GestureDetector(
                onTap: () {
                  Get.to(() => const LoginScreen());
                },
                child: Container(
                  child: const Card(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Already have an account LoginIn"),
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
