import 'package:flutter/material.dart';

import '../../Cards/CardStudent.dart';


class ListStudents extends StatefulWidget {
  const ListStudents({super.key});

  @override
  State<ListStudents> createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Students"),
        centerTitle: true,
      ),

      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index){
              return CardStudent();
            }
        ),
      ),
    );
  }
}
