import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st/Screens/pages/student/MyGrads.dart';
import 'package:st/Screens/pages/student/MyTearcher.dart';

import '../../StateManagement/AccountManagment.dart';
import 'Companies.dart';



class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountManagement>(
        builder: (context, accountProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Welcome ${accountProvider.account?.name}!", style: const TextStyle(fontSize: 30), textAlign: TextAlign.center,),

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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyGrads()));
                  },
                  child: Column(
                    children: [
                      Expanded(child: Image.asset('assets/education.png')),
                      const Text("My Grades", style: TextStyle(fontSize: 20, color: Colors.white),)
                    ],
                  )
              ),
            ),



            Row(
              children: [

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue
                    ),
                    width: 200,
                    height: 200,
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyTeacher()));
                        },
                        child: Column(
                          children: [
                            Expanded(child: Image.asset('assets/woman.png')),
                            Text("My Teacher", style: TextStyle(fontSize: 20, color: Colors.white),)
                          ],
                        )
                    ),
                  ),
                ),

                Expanded(

                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue
                    ),
                    width: 200,
                    height: 200,
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Companies()));
                        },
                        child: Column(
                          children: [
                            Expanded(child: Image.asset('assets/company.png')),
                            Text("Companies", style: TextStyle(fontSize: 20, color: Colors.white),)
                          ],
                        )
                    ),
                  ),
                ),

              ],
            )

          ],
        );
      }
    );
  }
}
