import 'package:flutter/material.dart';


class ProfileStudent extends StatefulWidget {
  const ProfileStudent({super.key});

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

      body: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/test/st1.png'),
          ),

          Text("July", style: TextStyle(fontSize: 25),),
          SizedBox(height: 5,),
          Text("Level : 3", style: TextStyle(fontSize: 15),),

          SizedBox(height: 50,),

          Text("teacher jwan she is lectures Programming Now she is supervisor for this summer term", textAlign: TextAlign.center,)

        ],
      ),
    );
  }
}
