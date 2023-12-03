import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st/Data/Data.dart';
import 'package:st/models/Account.dart';

import '../../../StateManagement/AccountManagment.dart';


class MyTeacher extends StatefulWidget {
  const MyTeacher({super.key});

  @override
  State<MyTeacher> createState() => _MyTeacherState();
}

class _MyTeacherState extends State<MyTeacher> {

  bool isSelect = false;

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
        title: const Text("My Teacher"),
        centerTitle: true,
      ),


      body:  Consumer<AccountManagement>(
          builder: (BuildContext context, AccountManagement value, Widget? child) {

            return Center(
              child: value.account?.idTeacher != ''? profile(value) : select_teacher(),
            );
        }
      ),
    );
  }


  String? teacher;
  Account? account;

  Widget profile(AccountManagement value){
    return   StreamBuilder(
        stream: getDB.onValue,
        builder: (context, snapshot) {
          if(snapshot.hasData) {

            Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map;

            print(map[value.account?.idTeacher]);

            Account teacherAccount = Account.fromJson(map[value.account?.idTeacher]);

            return Container(
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [

                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(teacherAccount.image!),
                  ),

                  Text("${teacherAccount.name}", style: const TextStyle(fontSize: 25),),
                  const SizedBox(height: 15,),

                  Text("Department : ${teacherAccount.department}", style: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 10,),
                  Text("University : ${teacherAccount.university}", style: const TextStyle(fontSize: 15), textAlign: TextAlign.center,),

                  const SizedBox(height: 50,),

                  Text(
                    "teacher ${teacherAccount.name} in department ${teacherAccount.department} Now she is supervisor for this summer term",
                    textAlign: TextAlign.center,)

                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
      }
    );
  }

  Widget select_teacher(){
    return  Consumer<AccountManagement>(

        builder: (BuildContext context, AccountManagement value, Widget? child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text("Select Your Teacher", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),

            const SizedBox(height: 50,),

            StreamBuilder(
              stream: getDB.onValue,
              builder: (context, snapshot) {
                if(snapshot.hasData) {

                  List<Account> teachers = [];
                  List<dynamic> list = [];
                  List<dynamic> listKey = [];
                  list.clear();
                  if(snapshot.data!.snapshot.value != null && snapshot.data!.snapshot.value.runtimeType != String){
                    Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map;
                    // print(map);
                    list = map.values.toList();
                    listKey = map.keys.toList();
                  }

                  for (int i = 0; i < list.length; i++) {
                    print("start");
                    // print(list[i]);
                    Account t = Account.fromJson(list[i]);
                    t.id = listKey[i];
                    if(t.positions == Positions.teacher.toString()){
                      teachers.add(t);
                    }
                  }

                  List<DropdownMenuItem<String>> dropdownItems = [];

                  for (Account item in teachers) {
                    dropdownItems.add(
                      DropdownMenuItem<String>(
                        value: item.name,
                        child: Row(
                          children: [
                            // Assuming you have an image URL associated with each name
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.image!, // Function to get image URL for the name
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              item.name!,
                              // style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }


                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    child: DropdownButton<String?>(
                      // menuMaxHeight: 500,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      isExpanded: true,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      value: teacher,
                      hint: const Center(child: Text(
                        "Select one", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),)),
                      underline: const SizedBox(),
                      onChanged: (String? value) {
                        print(value);

                        for (Account item in teachers) {
                          if(item.name == value){
                            account = item;
                          }
                        }

                        setState(() {
                          teacher = value!;
                        });

                      },
                      alignment: Alignment.bottomRight,
                      borderRadius: BorderRadius.circular(15),
                      items: dropdownItems
                    )
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              }
            ),

            const SizedBox(height: 100,),

            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: InkWell(
                onTap: () async{
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  // isSelect = true;

                  DatabaseReference ref = FirebaseDatabase.instance.ref("users");

                  print(account?.id);

                  await ref.update({
                      "${value.user_id}/idTeacher": account?.id,
                    });

                  setState(() {
                  });

                },
                child: const Center(child: Text("Save", style: TextStyle(fontSize: 18, color: Colors.white),)),
              ),
            )

          ],
        );
      }
    );
  }

}
