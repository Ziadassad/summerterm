import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../StateManagement/AccountManagment.dart';
import '../../../../models/DayOfActive.dart';


class DayOfWorking extends StatefulWidget {
  const DayOfWorking({super.key});

  @override
  State<DayOfWorking> createState() => _DayOfWorkingState();
}

class _DayOfWorkingState extends State<DayOfWorking> {

  late DatabaseReference dbActive;
  AccountManagement? accountManagement;

  int? absent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    accountManagement = Provider.of<AccountManagement>(context, listen: false);

    dbActive = FirebaseDatabase.instance.ref("users").child("${accountManagement?.user_id}/daysOFActive");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountManagement>(

        builder: (BuildContext context, AccountManagement value, Widget? child) {
        return Container(
          child: Column(
            children: [

              StreamBuilder(
                  stream: dbActive.onValue,
                  builder: (context, snapshot) {
                    print("dddddddd");
                    print(snapshot.data?.snapshot.value);
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

                        print(activeList[0]);

                        absent = activeList.length;

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
        );
      }
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
            Text(dayActive.days!),
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
}
