import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController noteController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: InputDecoration(hintText: "Add Note"),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var note = noteController.text.trim();
                  if (note != "") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("notes")
                          .doc()
                          .set({
                        "createdAt": DateTime.now(),
                        "note": note,
                        "userId": userId?.uid,
                      });
                    } catch (e) {
                      print("Error $e");
                    }
                  } else {}
                },
                child: Text("Add Note"))
          ],
        ),
      ),
    );
  }
}
