import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:st/Data/Data.dart';
import 'package:st/Screens/Login/LoginPage.dart';
import 'package:st/Screens/pages/Companies.dart';
import 'package:st/Screens/pages/CompanyPage.dart';
import 'package:st/Screens/pages/StudentPage.dart';
import 'package:st/Screens/pages/TeacherPage.dart';
import 'package:st/Screens/pages/student/MyGrads.dart';
import 'package:st/Screens/pages/student/MyTearcher.dart';

import '../StateManagement/AccountManagment.dart';
import '../models/Account.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late DatabaseReference dbCategory;
  late Query getDB;

  @override
  void initState() {
    super.initState();

    getDB = FirebaseDatabase.instance.ref("users");

  }

  List levels = [
    StudentPage(),
    TeacherPage(),
    CompanyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("Summer Term"),
        centerTitle: true,

        actions: [

          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [

                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Logout"),
                  ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  Provider.of<AccountManagement>(context, listen: false).setLogoutAccount();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }
              }
          ),

        ],
      ),

      body:  Consumer<AccountManagement>(

          builder: (BuildContext context, AccountManagement value, Widget? child) {

            print("Home Page");
            print(value.user_id);

          return StreamBuilder(
            stream: getDB.onValue,
            builder: (context, snapshot) {
              print(snapshot.hasData);
              print(snapshot.connectionState);

              if(snapshot.hasData){

                Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map;

                print(map[value.user_id]);

                Account account = Account.fromJson(map[value.user_id]);

                 int level = getAccount(account);

                return levels[level];
              }
              return const Center(child: CircularProgressIndicator());
            }
          );
        }
      ),
    );
  }

  int getAccount(Account account) {



    Provider.of<AccountManagement>(context, listen: false).setAccount(account);


    print("zzzzzzzzzz");
    print(account.positions);

    switch(account.positions){

      case 'Positions.student':
        return 0;
      case 'Positions.teacher':
        return 1;
      case 'Positions.company':
        return 2;

      default:
        return 0;
    }

  }

  Future<bool> rebuild() async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return false;
    }

    setState(() {});
    return true;
  }

}
