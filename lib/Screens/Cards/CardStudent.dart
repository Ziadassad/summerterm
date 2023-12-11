import 'package:flutter/material.dart';
import 'package:st/Screens/pages/ProfileStudent.dart';
import 'package:st/models/Account.dart';


class CardStudent extends StatefulWidget {

  final Account student;

  const CardStudent({super.key, required this.student});

  @override
  State<CardStudent> createState() => _CardStudentState();
}

class _CardStudentState extends State<CardStudent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileStudent(student: widget.student,)));
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
                      backgroundImage: NetworkImage(widget.student.image!),
                    ),

                    const SizedBox(width: 10,),

                    Text(widget.student.name!)
                  ],
                ),

               Container(
                 width: 70,
                 child: Column(
                   children: [
                     InkWell(
                       onTap: (){

                       },
                       child: Container(
                         width: 70,
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
                       onTap: (){

                       },
                       child: Container(
                         width: 70,
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
               )
              ],
            ),

            const SizedBox(height: 10,),

            Text("University : ${widget.student.name}",
            style: const TextStyle(fontSize: 12),),

            Text("Department : ${widget.student.department}",
            style: const TextStyle(fontSize: 11),),

            Text("Level: ${widget.student.stage}")

          ],
        ),
      ),
    );
  }
}
