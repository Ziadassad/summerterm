import 'package:flutter/material.dart';

import '../../Companies.dart';




class SelectTeacher extends StatelessWidget {
  const SelectTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),
        const Text("Select your Teacher \n", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        const Text("In this step you need Select your Teacher to be your supervisor in this summer term"
            " \n if you are need any help or equations \n",
          textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
        const Text("Click here for searching companies : ", style: TextStyle(fontWeight: FontWeight.w300),),

        const SizedBox(height: 50,),

        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Companies()));
          },
          child: Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueAccent
            ),
            child: const Center(child: Text("Companies", style: TextStyle(fontSize: 18, color: Colors.white),)),
          ),
        )
      ],
    );
  }
}
