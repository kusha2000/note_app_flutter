import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter/views/homeScreen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: noteController
                  ..text = Get.arguments['note'].toString(),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("notes")
                        .doc(Get.arguments['docId'].toString())
                        .update(
                      {
                        'note': noteController.text.trim(),
                      },
                    ).then((value) => {
                              Get.offAll(() => const HomeScreen()),
                              log("Data Updated"),
                            });
                  },
                  child: const Text("Update")),
              Lottie.asset("assets/Animation - 1708582962554.json"),
            ],
          ),
        ),
      ),
    );
  }
}
