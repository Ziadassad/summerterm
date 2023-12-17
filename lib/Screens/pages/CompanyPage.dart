import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st/Screens/pages/company/ActiveStudent.dart';
import 'package:st/Screens/pages/company/ProfileCompany.dart';
import 'package:st/Screens/pages/company/StudentRequst.dart';
import 'package:st/Screens/pages/student/MyGrads.dart';
import 'package:st/Screens/pages/student/MyTearcher.dart';

import '../../StateManagement/AccountManagment.dart';
import 'Companies.dart';



class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
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
                height: 220,
                child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileCompany()));
                    },
                    child: Column(
                      children: [
                        Expanded(child: Image.asset('assets/info_company.png', width: 300,)),
                        const Text("Info Company", style: TextStyle(fontSize: 20, color: Colors.white),)
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StudentRequst()));
                          },
                          child: Column(
                            children: [
                              Expanded(child: Image.asset('assets/inbox_1161728.png')),
                              const Text("Student Request", style: TextStyle(fontSize: 18, color: Colors.white),)
                            ],
                          )
                      ),
                    ),
                  ),

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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ActiveStudent()));
                          },
                          child: Column(
                            children: [
                              Expanded(child: Image.asset('assets/tick_1161751.png')),
                              const Text("Active Student", style: TextStyle(fontSize: 20, color: Colors.white),)
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
