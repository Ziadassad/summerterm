import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../Data/Data.dart';
import '../../../models/Account.dart';
import '../../Cards/CardStudent.dart';


class ListStudents extends StatefulWidget {
  const ListStudents({super.key});

  @override
  State<ListStudents> createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {

  late DatabaseReference dbCategory;
  late Query getDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDB = FirebaseDatabase.instance.ref("users");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Students"),
        centerTitle: true,
      ),

      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: getDB.onValue,
          builder: (context, snapshot) {

            if(snapshot.hasData){
              List<Account> companies = [];
              List<dynamic> list = [];
              List<dynamic> listKey = [];
              list.clear();

              Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map;

              list = map.values.toList();
              listKey = map.keys.toList();

              for (int i = 0; i < list.length; i++) {
                Account t = Account.fromJson(list[i]);
                t.id = listKey[i];
                if(t.name == Positions.company.toString()){
                  companies.add(t);
                }
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index){
                    return CardStudent();
                  }
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          }
        ),
      ),
    );
  }
}
