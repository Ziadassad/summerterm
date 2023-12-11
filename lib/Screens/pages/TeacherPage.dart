import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st/Screens/pages/teacher/ListStudents.dart';
import '../../StateManagement/AccountManagment.dart';
import 'Companies.dart';


class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AccountManagement>(
        builder: (context, accountProvider, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [

              Text("Welcome ${accountProvider.account!.name}!", style: const TextStyle(fontSize: 30), textAlign: TextAlign.center,),

              const SizedBox(height: 60,),


              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue
                ),
                width: double.infinity,
                height: 200,
                child: InkWell(
                    onTap: (){
                      print("ziad");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListStudents()));
                    },
                    child: Column(
                      children: [
                        Expanded(child: Image.asset('assets/students.png')),
                        const Text("My Students", style: TextStyle(fontSize: 20, color: Colors.white),)
                      ],
                    )
                ),
              ),



              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue
                ),
                width: double.infinity,
                height: 200,
                child: InkWell(
                    onTap: (){
                      print("ziad");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Companies()));
                    },
                    child: Column(
                      children: [
                        Expanded(child: Image.asset('assets/company.png')),
                        const Text("Companies", style: TextStyle(fontSize: 20, color: Colors.white),)
                      ],
                    )
                ),
              )

            ],
          ),
        );
      }
    );
  }

}
