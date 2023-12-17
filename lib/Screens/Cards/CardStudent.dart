import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:st/Screens/pages/ProfileStudent.dart';
import 'package:st/models/Account.dart';

import '../../StateManagement/AccountManagment.dart';
import '../../models/DayOfActive.dart';


class CardStudent extends StatefulWidget {

  final Account student;
  final bool accept;

  const CardStudent({super.key, required this.student, required this.accept});

  @override
  State<CardStudent> createState() => _CardStudentState();
}

class _CardStudentState extends State<CardStudent> {

  DatabaseReference? ref;
  AccountManagement? accountManagement;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref = FirebaseDatabase.instance.ref("users");

    accountManagement = Provider.of<AccountManagement>(context, listen: false);


    check_student();

  }

  String status = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileStudent(student: widget.student, status: status,)));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black)
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(widget.student.image!),
                    ),

                    const SizedBox(width: 10,),

                    Text(widget.student.name!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                  ],
                ),


               accountManagement!.account!.positions!.toString().contains('company')?


              !widget.accept?
              condistionStudent():
                          Container(
                            width: 70,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Text("Active", textAlign: TextAlign.center,),
                          )

                   :
               Container(
                 width: 78,
                 padding: const EdgeInsets.all(7),
                 decoration: BoxDecoration(
                     color: Colors.green,
                     borderRadius: BorderRadius.circular(10)
                 ),
                 child: Text(status, textAlign: TextAlign.center,),
               ),

              ],
            ),

            const SizedBox(height: 10,),

            Text("University : ${widget.student.university}",
            style: const TextStyle(fontSize: 12),),
            const SizedBox(height: 5,),
            Text("Department : ${widget.student.department}",
            style: const TextStyle(fontSize: 14),),
            const SizedBox(height: 5,),
            Text("Level: ${widget.student.stage}")

          ],
        ),
      ),
    );
  }

  condistionStudent() {
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          InkWell(
            onTap: () async{

              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  text: 'Do you want to Accept ${widget.student.name}',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Colors.green,
                  onConfirmBtnTap: () async{
                    await ref?.update({
                      "${widget.student.id}/Company": {
                        'idCompany': accountManagement?.user_id,
                        'accept': true,
                        'reject': false
                      },
                    });
                    Navigator.pop(context);
                  }
              );

            },
            child: Container(
              width: 75,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Text("Accept", textAlign: TextAlign.center,),
            ),
          ),
          const SizedBox(height: 5,),
          InkWell(
            onTap: () async{
              await ref?.child('${widget.student.id}/Company').remove();

              Navigator.pop(context);
            },
            child: Container(
              width: 75,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Text("Reject", textAlign: TextAlign.center,),
            ),
          ),
        ],
      ),
    );
  }

  void check_student() {

    if(widget.student.idTeacher != ''){
      status = "Searching";
    }
    if(widget.student.company != null){
      status = "Waiting";
    }
    if(widget.student.company?['accept'] == true){
      status = "Active";
    }

    List<DayActive> activeList = [];
    List<dynamic> list = [];
    list.clear();


    if(widget.student.daysOFActive != null){
      Map<dynamic, dynamic> map = widget.student.daysOFActive as Map;

      list = map.values.toList();
      for (int i = 0; i < list.length; i++) {
        DayActive t = DayActive.fromJson(list[i]);
        activeList.add(t);
      }

      if(activeList.length >= 30){
        status = "Finished";
      }
    }

  }

}
