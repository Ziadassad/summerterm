import 'package:flutter/material.dart';

import '../../models/Account.dart';


class ProfileStudent extends StatefulWidget {
  final Account student;
  const ProfileStudent({super.key, required this.student});

  @override
  State<ProfileStudent> createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Student"),
      ),

      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("${widget.student.image}"),
            ),

            Text("${widget.student.name}", style: const TextStyle(fontSize: 25),),
            const SizedBox(height: 5,),
            Text("Level : ${widget.student.stage}", style: const TextStyle(fontSize: 15),),

            const SizedBox(height: 50,),

            const Text("Department", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text("${widget.student.department}", textAlign: TextAlign.center, style: const TextStyle(fontSize: 18),),

            const SizedBox(height: 50,),

            const Text("Status", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            Text("${widget.student.department}", textAlign: TextAlign.center, style: const TextStyle(fontSize: 18),)

          ],
        ),
      ),
    );
  }
}
