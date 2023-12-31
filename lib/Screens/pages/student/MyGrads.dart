import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:st/Screens/pages/student/StepPages/DayOfWorking.dart';
import 'package:st/Screens/pages/student/StepPages/Finish.dart';
import 'package:st/Screens/pages/student/StepPages/SelectTeacher.dart';
import 'package:st/StateManagement/AccountManagment.dart';

import '../../../models/DayOfActive.dart';
import 'StepPages/SearchForCompany.dart';
import 'StepPages/Waiting.dart';




class MyGrads extends StatefulWidget {
  const MyGrads({super.key});

  @override
  State<MyGrads> createState() => _MyGradsState();
}

class _MyGradsState extends State<MyGrads> {


  AccountManagement? accountManagement;

  bool? isFinish = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    accountManagement = Provider.of<AccountManagement>(context, listen: false);

    print(accountManagement?.user_id);

    print(accountManagement!.account!.company);
    print(accountManagement!.account!.company != null);
    print(accountManagement!.account!.company != null);

    if(accountManagement!.account!.idTeacher != ''){
      activeStep = 1;
    }
    if(accountManagement!.account!.company != null){
      activeStep = 2;
    }
    if(accountManagement!.account!.company?['accept'] == true){
      activeStep = 3;
    }

    List<DayActive> activeList = [];
    List<dynamic> list = [];
    list.clear();

    if(accountManagement!.account!.daysOFActive != null){
      Map<dynamic, dynamic> map = accountManagement!.account!.daysOFActive as Map;

      list = map.values.toList();
      for (int i = 0; i < list.length; i++) {
        DayActive t = DayActive.fromJson(list[i]);
        activeList.add(t);
      }

      if(activeList.length >= 30){
        isFinish = true;
        activeStep = 4;
      }
    }

    print(accountManagement!.account!.daysOFActive);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Grads"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          stepper(),

          Container(
            margin: const EdgeInsets.symmetric( vertical: 10),
            width: double.infinity,
            child: pages[activeStep],
          )

        ],
      ),
    );
  }

  List<Widget> pages = [
    const SelectTeacher(),
    const SearchForComapny(),
    const Waiting(),
    const DayOfWorking(),
    const Finish()
  ];


  int activeStep = 0;

  int reachedStep = 0;
  int upperBound = 5;
  double progress = 0.2;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};
  final dashImages = [
    'assets/stepper/search.gif',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
  ];

  void increaseProgress() {
    if (progress < 1) {
      setState(() => progress += 0.2);
    } else {
      setState(() => progress = 0);
    }
  }

  stepper(){
    return EasyStepper(
      steppingEnabled: false,
      enableStepTapping: false,
      activeStep: activeStep,
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 15,
      borderThickness: 2,
      padding: const EdgeInsets.all(20),
      stepRadius: 28,
      finishedStepBorderColor: Colors.green,
      finishedStepTextColor: Colors.green,
      finishedStepBackgroundColor: Colors.green,
      activeStepIconColor: Colors.green,
      showLoadingAnimation: false,
      // showLoadingAnimation: activeStep != 0 ? true : false,

      steps: [
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 0 ? 1 : 0.3,
              child: Image.asset('assets/woman.png'),
            ),
          ),
          customTitle: const Text(
            'MyTeacher',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 1 ? 1 : 0.3,
              child: Image.asset('assets/stepper/search.gif'),
            ),
          ),
          customTitle: const Text(
            'Search',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 2 ? 1 : 0.3,
              child: Image.asset('assets/stepper/waiting.gif'),
            ),
          ),
          customTitle: const Text(
            'Waiting',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 3 ? 1 : 0.3,
              child: Image.asset('assets/stepper/working.png'),
            ),
          ),
          customTitle: const Text(
            'day of working',
            textAlign: TextAlign.center,
          ),
        ),

        EasyStep(
          customStep:
          ClipRRect(

            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 4 ? 1 : 0.3,
              child: Image.asset('assets/derp.gif'),
            ),
          ),
          customTitle: const Text(
            'Finish',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
      onStepReached: (index) => setState(() => activeStep = index),
    );

  }
}
