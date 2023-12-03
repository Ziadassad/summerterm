import 'package:flutter/material.dart';
import 'package:st/Screens/pages/ProfileStudent.dart';


class CardStudent extends StatefulWidget {
  const CardStudent({super.key});

  @override
  State<CardStudent> createState() => _CardStudentState();
}

class _CardStudentState extends State<CardStudent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileStudent()));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                      backgroundImage: AssetImage('assets/test/st1.png'),
                    ),

                    SizedBox(width: 10,),

                    Text("angel")
                  ],
                ),

               Container(
                 padding: const EdgeInsets.all(7),
                 decoration: BoxDecoration(
                   color: Colors.red,
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child: Text("Applied"),
               )
              ],
            ),

            SizedBox(height: 10,),

            Text("Univeristy : Salahaddin universty college of engineer",
            style: TextStyle(fontSize: 12),),

            Text("Department : Software Engineer",
            style: TextStyle(fontSize: 11),),

            Text("Level: 3")

          ],
        ),
      ),
    );
  }
}
