import 'package:flutter/material.dart';


class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
       ClipRRect(
         borderRadius: BorderRadius.circular(15),
            child: Image.asset('assets/stepper/waiting.gif')
        ),


        const SizedBox(height: 20,),

        const Text("Waiting For Approved ", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        const SizedBox(height: 10,),
        const Text("please wait from this company you applied thank you for your attention", textAlign: TextAlign.center,),
      ],
    );
  }
}
