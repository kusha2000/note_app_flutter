import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app_flutter/views/createNoteScreen.dart';
import 'package:note_app_flutter/views/signInScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.off(() => const LoginScreen());
              },
              child: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("notes")
              .where("userId", isEqualTo: userId?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong!");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Data Found!"),
              );
            }
            if (snapshot != null && snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var note = snapshot.data!.docs[index]['note'];
                    DateTime date =
                        (snapshot.data!.docs[index]['createdAt']).toDate();
                    String formatDate =
                        DateFormat('yyyy-MM-dd – kk:mm').format(date);
                    return Card(
                      child: ListTile(
                        title: Text(note),
                        subtitle: Text(formatDate),
                        trailing: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 10),
                            Icon(Icons.delete),
                          ],
                        ),
                      ),
                    );
                  });
            }

            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateNoteScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
