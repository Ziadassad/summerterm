import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../StateManagement/AccountManagment.dart';


class ProfileCompany extends StatefulWidget {
  const ProfileCompany({super.key});

  @override
  State<ProfileCompany> createState() => _ProfileCompanyState();
}

class _ProfileCompanyState extends State<ProfileCompany> {


  TextEditingController info = TextEditingController();

  late DatabaseReference dbCategory;
  late Query getDB;

  @override
  void initState() {
    super.initState();

    getDB = FirebaseDatabase.instance.ref("users");


  }


  @override
  Widget build(BuildContext context) {
    return  Consumer<AccountManagement>(
        builder: (BuildContext context, AccountManagement value, Widget? child) {

          info.text = value.account!.info!;

          return Scaffold(

          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(value.account!.image!),
                    ),

                    Text("${value.account!.name}", style: const TextStyle(fontSize: 25),),
                    const SizedBox(height: 15,),

                    Text("Company Service : ${value.account!.department}", style: const TextStyle(fontSize: 18),),

                    const SizedBox(height: 50,),

                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextField(
                        controller: info,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: 'About company ...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        minLines: 5,//Normal textInputField will be displayed
                        maxLines: 15,// when user presses enter it will adapt to it
                      ),
                    ),

                    const SizedBox(height: 20,),


                    Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: InkWell(
                        onTap: () async{

                          DatabaseReference ref = FirebaseDatabase.instance.ref("users");

                          await ref.update({
                            "${value.user_id}/info": info.text,
                          });

                          await QuickAlert.show(
                            text: 'change Successfully!',
                            context: context,
                            type: QuickAlertType.success,
                          ); // Th

                          setState(() {
                          });


                        },
                        child: const Center(child: Text("Save and Change", style: TextStyle(fontSize: 18, color: Colors.white),)),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}