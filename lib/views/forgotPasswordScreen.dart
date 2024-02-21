// ignore: file_names
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(onPressed: () {}, child: Text("Forgot Password")),
            ],
          ),
        ),
      ),
    );
  }
}
