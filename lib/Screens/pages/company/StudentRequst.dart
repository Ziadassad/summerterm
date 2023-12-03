import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StudentRequst extends StatefulWidget {
  const StudentRequst({super.key});

  @override
  State<StudentRequst> createState() => _StudentRequstState();
}

class _StudentRequstState extends State<StudentRequst> {

  late DatabaseReference dbCategory;
  late Query getDB;

  @override
  void initState() {
    super.initState();

    getDB = FirebaseDatabase.instance.ref("users");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Student"),
        centerTitle: true,
      ),
    );
  }
}
