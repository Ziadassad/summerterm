import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Data/Data.dart';
import '../../../StateManagement/AccountManagment.dart';
import '../../../models/Account.dart';
import '../../Cards/CardCompany.dart';


class VerifiedCompany extends StatefulWidget {
  const VerifiedCompany({super.key});

  @override
  State<VerifiedCompany> createState() => _VerifiedCompanyState();
}

class _VerifiedCompanyState extends State<VerifiedCompany> {


  late Query getDB;
  AccountManagement? accountManagement;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDB = FirebaseDatabase.instance.ref("users");

    accountManagement = Provider.of<AccountManagement>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Companies", style: TextStyle(color: Colors.lightBlue),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: StreamBuilder(
          stream: getDB.onValue,
          builder: (context, snapshot) {

            if(snapshot.hasData) {

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
                if(t.positions == Positions.company.toString() && !t.is_verified!){
                  companies.add(t);
                }
              }


              return ListView.builder(
                  itemCount: companies.length,
                  itemBuilder: (context, index) {
                    return CardCompany(company: companies[index],);
                  }
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}
