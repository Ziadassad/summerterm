import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../../StateManagement/AccountManagment.dart';
import '../../models/Account.dart';
import 'package:intl/intl.dart';

import '../../models/DayOfActive.dart';

const weekDays = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];

class ProfileStudent extends StatefulWidget {
  final Account student;
  final String status;
  const ProfileStudent({super.key, required this.student, required this.status});

  @override
  State<ProfileStudent> createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {

  DatabaseReference? ref;
  late DatabaseReference dbActive;

  DateTime? datePiker = DateTime.now();

  TimeOfDay? timeStart = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay? timeEnd = TimeOfDay.now();

  String startTime = '';
  String endTime = '';

  int? days = 0;
  int? numDay = 0;
  bool? hasCome = false;


  List<DayActive>? dayOfActive;

  AccountManagement? accountManagement;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountManagement = Provider.of<AccountManagement>(context, listen: false);
    ref = FirebaseDatabase.instance.ref("users");

    dbActive = FirebaseDatabase.instance.ref("users").child("${widget.student.id}/daysOFActive");

    startTime = DateFormat('h:mm a').format(DateTime(2023, 1, 1, timeStart!.hour, timeStart!.minute));
    endTime = DateFormat('h:mm a').format(DateTime(2023, 1, 1, timeEnd!.hour, timeEnd!.minute));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Student"),
      ),

      body: Consumer<AccountManagement>(

          builder: (BuildContext context, AccountManagement value, Widget? child) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage("${widget.student.image}"),
                  ),

                  Text("${widget.student.name}", style: const TextStyle(fontSize: 25),),
                  const SizedBox(height: 5,),
                  Text("Level : ${widget.student.stage}", style: const TextStyle(fontSize: 15),),

                  const SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Contact me: ", style: const TextStyle(fontSize: 20),),
                      const SizedBox(width: 5,),
                      Text("${widget.student.email}", style: const TextStyle(fontSize: 17),),
                    ],
                  ),


                  const SizedBox(height: 30,),

                  const Text("University : ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  Text("${widget.student.university} \n", textAlign: TextAlign.center, style: const TextStyle(fontSize: 14),),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Column(
                        children: [
                          const Text("Department : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text("${widget.student.department}", textAlign: TextAlign.center, style: const TextStyle(fontSize: 18),),
                        ],
                      ),

                      const SizedBox(height: 50,),

                      Column(
                        children: [
                          const Text("Status : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),),

                          Text(widget.status, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18),)
                      ],)

                    ],
                  ),

                  StreamBuilder(
                    stream: dbActive.onValue,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){

                        List<DayActive> activeList = [];
                        List<dynamic> list = [];
                        List<dynamic> listKey = [];
                        list.clear();

                        if(snapshot.data?.snapshot.value != null){
                          Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map;

                          list = map.values.toList();
                          listKey = map.keys.toList();

                          for (int i = 0; i < list.length; i++) {
                            DayActive t = DayActive.fromJson(list[i]);
                            t.id = listKey[i];
                            activeList.add(t);
                          }

                          numDay = activeList.length;

                        }
                        return Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 45,
                              horizontalMargin: 2,
                              columns: const [
                                DataColumn(label: Text("day")),
                                DataColumn(label: Text("date")),
                                DataColumn(label: Text("start - end")),
                                DataColumn(label: Text("has\ncome")),
                                DataColumn(label: Text("time of\n active")),
                              ],

                              rows: [
                                for(DayActive day in activeList)
                                  rowOfDays(day)
                              ],

                            ),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  )

                ],
              ),
            ),
          );
        }
      ),

      floatingActionButton: accountManagement!.account!.positions!.toString().contains('company')?
      FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },

        child: const Icon(Icons.add),
      )
      :
          const SizedBox.shrink()
      ,
    );
  }

  rowOfDays(DayActive dayActive){
    return DataRow(
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.redAccent;
        }
        return Colors.greenAccent;
      }),
      selected: !dayActive.hasCome!,
        cells: [
          DataCell(
            Row(
              children: [
                Text(dayActive.days!),
                accountManagement!.account!.positions!.toString().contains('company')? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {

                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      text: 'Do you want delete this date ${dayActive.date}',
                      confirmBtnText: 'Yes',
                      cancelBtnText: 'No',
                      confirmBtnColor: Colors.green,
                      onConfirmBtnTap: () async {

                        await ref?.child('${widget.student.id}/daysOFActive/${dayActive.id}')
                            .remove().
                        then((_) async{
                          await QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: "Delete Successfully!",
                              );

                            }).catchError((error) {
                              print("Deletion failed: $error");
                            });

                        Navigator.pop(context);
                      }
                    );




                  },
                ):
                SizedBox.shrink(),
              ],
            ),
          ),
          DataCell(Text("${dayActive.date}")),
          DataCell(Text("${dayActive.timeStart!}-${dayActive.timeEnd!}")),
          DataCell(
              Checkbox(
                value: dayActive.hasCome,
                onChanged: (bool? value) {  },
              )
          ),
          DataCell(Text("${dayActive.duration}")),
        ]);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context2) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text('Add day of active student', textAlign: TextAlign.center,),
          content: StatefulBuilder(
              builder: (context, setState2) {
              return SingleChildScrollView(
                child: Center(
                  child: ListBody(
                    children: <Widget>[
                      selectDateButton(setState2),
                      const SizedBox(height: 15,),
                      selectTimeActive(setState2),
                      const SizedBox(height: 15,),

                      CheckboxListTile(

                        title: const Text("Has Come", style: TextStyle(fontSize: 20),),
                        value: hasCome,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Colors.black),
                        ),
                        onChanged: (newValue) {
                          setState2(() {
                            hasCome = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                      )


                    ],
                  ),
                ),
              );
            }
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add', style: TextStyle(fontSize: 18, color: Colors.green),),
              onPressed: () async{
                days = datePiker?.weekday;
                final duration = calculateDuration(timeStart!, timeEnd!);

                var map = {
                  'hasCome': hasCome,
                  'numDay': numDay! + 1,
                  'timeStart': startTime,
                  'timeEnd': endTime,
                  'duration': duration.inHours,
                  'days': weekDays[days! -1],
                  'date': datePiker.toString().split(' ')[0]
                };


                await ref?.child("${widget.student.id}").child('daysOFActive').push().set(map);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  selectDateButton(setState2) {
    return  InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: (){
        dateTimePiker(setState2);
        setState2(() {

        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.lightBlue
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(datePiker.toString().split(' ')[0], textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.white,),),
            const Icon(Icons.date_range_rounded, color: Colors.white,)
          ],
        ),
      ),
    );
  }

  selectTimeActive(setState2) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: (){
        timePiker(setState2);
        setState2(() {

        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.lightBlue
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(startTime, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.white,),),

                const SizedBox(width: 5,),
                Text(endTime, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.white,),),
              ],
            ),
            const Icon(Icons.timelapse_rounded, color: Colors.white,)
          ],
        ),
      ),
    );
  }



  dateTimePiker(StateSetter setState2) async{

    BottomPicker.date(
      title:  "Set date active",
      // initialDateTime: DateTime.utc(2023, 1, 1),
      titleStyle: const TextStyle(
          fontWeight:  FontWeight.bold,
          fontSize:  15,
          color:  Colors.blue
      ),
      onChange: (index) {
        datePiker = index;

      },
      onSubmit: (index) {
        datePiker = index;
        setState2(() {
        });
      },
      // bottomPickerTheme:  BOTTOM_PICKER_THEME.plumPlate
    ).show(context);
  }

  timePiker(setState2){
    showTimeRangePicker(
      context: context,
      start: timeStart,
      end: timeEnd,
      onStartChange: (start) {

        timeStart = start;
        startTime = DateFormat('h:mm a').format(DateTime(2023, 1, 1, timeStart!.hour, timeStart!.minute));
        setState2(() {});

      },
      onEndChange: (end) {

        timeEnd = end;
        endTime = DateFormat('h:mm a').format(DateTime(2023, 1, 1, timeEnd!.hour, timeEnd!.minute));
        setState2(() {});
      },
      interval: const Duration(hours: 1),
      minDuration: const Duration(hours: 1),
      use24HourFormat: false,
      padding: 30,
      strokeWidth: 20,
      handlerRadius: 14,
      strokeColor: Colors.orange,
      handlerColor: Colors.orange[700],
      selectedColor: Colors.amber,
      backgroundColor: Colors.black.withOpacity(0.3),
      ticks: 12,
      ticksColor: Colors.white,
      snap: true,
      labels: [
        "12 am",
        "3 am",
        "6 am",
        "9 am",
        "12 pm",
        "3 pm",
        "6 pm",
        "9 pm"
      ].asMap().entries.map((e) {
        return ClockLabel.fromIndex(
            idx: e.key, length: 8, text: e.value);
      }).toList(),
      labelOffset: -30,
      labelStyle: const TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontWeight: FontWeight.bold),
      timeTextStyle: TextStyle(
          color: Colors.orange[700],
          fontSize: 24,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
      activeTimeTextStyle: const TextStyle(
          color: Colors.orange,
          fontSize: 22,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
    );
  }


  Duration calculateDuration(TimeOfDay start, TimeOfDay end) {
    DateTime startDate = DateTime(2023, 1, 1, start.hour, start.minute);
    DateTime endDate = DateTime(2023, 1, 1, end.hour, end.minute);

    if (endDate.isBefore(startDate)) {
      endDate = endDate.add(const Duration(days: 1));
    }

    return endDate.difference(startDate);
  }
}
