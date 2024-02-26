import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/viewData.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';

class EnterData extends StatefulWidget {
  EnterData({super.key});

  @override
  State<EnterData> createState() => _EnterDataState();
}

class _EnterDataState extends State<EnterData> {
  TextEditingController note = TextEditingController();
  TextEditingController notecontent = TextEditingController();

  CollectionReference colletion =
      FirebaseFirestore.instance.collection('colletion');
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return colletion
        .add({
          'full_name': note.text,
          'notecontent': notecontent.text // John Doe
        })
        .then((value) => print("User Added"))
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Flutter",
              style: TextStyle(fontSize: 30),
            ),
            Container(
              width: 250,
              child: TextField(
                controller: note,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your name',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 250,
              child: TextField(
                controller: notecontent,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'note content',
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                addUser();
                note.clear();
                notecontent.clear();
                Get.to(() => ViewData());
                Get.snackbar(
                  "Your name",
                  "Added to the list",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: Duration(milliseconds: 700),
                );
              },
              child: Text(
                "Submit Data",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => ViewData());
                },
                child: Text("View Data Page"))
          ],
        ),
      ),
    );
  }
}
