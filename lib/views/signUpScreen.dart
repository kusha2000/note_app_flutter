// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter/views/signInScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: Icon(Icons.visibility),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(onPressed: () {}, child: Text("Sign Up")),
              GestureDetector(
                onTap: () {
                  Get.to(() => LoginScreen());
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
