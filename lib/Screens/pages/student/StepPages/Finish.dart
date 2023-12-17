import 'package:flutter/material.dart';



class Finish extends StatefulWidget {
  const Finish({super.key});

  @override
  State<Finish> createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          const Text("Congratulation", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),

          const SizedBox(height: 30,),
          
          Text("Your Successfully Finished Summer Term", style: TextStyle(fontSize: 18),),
          SizedBox(height: 20,),
          Image.asset('assets/derp.gif')
          
        ],
      ),
    );
  }
}
