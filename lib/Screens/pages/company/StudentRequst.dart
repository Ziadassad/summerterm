import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Data/Data.dart';
import '../../../StateManagement/AccountManagment.dart';
import '../../../models/Account.dart';
import '../../Cards/CardStudent.dart';

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

      body:  Consumer<AccountManagement>(

          builder: (BuildContext context, AccountManagement value, Widget? child) {

            return Container(
              margin: const EdgeInsets.all(10),
              child: StreamBuilder(
                  stream: getDB.onValue,
                  builder: (context, snapshot) {

                    if(snapshot.hasData){
                      List<Account> students = [];
                      List<dynamic> list = [];
                      List<dynamic> listKey = [];
                      list.clear();

                      Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map;

                      list = map.values.toList();
                      listKey = map.keys.toList();

                      for (int i = 0; i < list.length; i++) {
                        Account t = Account.fromJson(list[i]);
                        t.id = listKey[i];
                        print("${value.user_id! } ${t.idTeacher}");
                        if(value.account!.company?['idCompany'] == t.company?['idCompany'] && t.positions == Positions.student.toString()){
                          students.add(t);
                        }
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: students.length,
                          itemBuilder: (context, index){
                            return CardStudent(student: students[index],);
                          }
                      );
                    }
                    return const Center(child: CircularProgressIndicator(),);
                  }
              ),
            );
          }
      ),
    );
  }
}
