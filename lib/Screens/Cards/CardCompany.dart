import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../StateManagement/AccountManagment.dart';
import '../../models/Account.dart';


class CardCompany extends StatefulWidget {

  final Account company;

  const CardCompany({super.key, required this.company});

  @override
  State<CardCompany> createState() => _CardCompanyState();
}

class _CardCompanyState extends State<CardCompany> {

  bool isLiked = false;
  bool isApplied = false;

  late AccountManagement accountManagement;
  DatabaseReference? ref;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref = FirebaseDatabase.instance.ref("users");

    accountManagement = Provider.of<AccountManagement>(context, listen: false);

    if(accountManagement.account?.company != null && accountManagement.account!.company?['idCompany'] == widget.company.id){
      isApplied = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<AccountManagement>(

        builder: (BuildContext context, AccountManagement value, Widget? child) {

        return Container(
          // height: 300,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.company.image!),
                      ),

                      const SizedBox(width: 10,),
                      Text(widget.company.name!, style: const TextStyle(fontSize: 18),)
                    ],
                  ),
                  // Text("sended", style: TextStyle(color: Colors.blueAccent),)
                ],

              ),

              const SizedBox(height: 20,),

              Text("${widget.company.info}"),


              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                    onTap: (){
                      isLiked = !isLiked;
                      setState(() {

                      });
                    },
                    child: Icon(
                      isLiked? Icons.favorite : Icons.favorite_border,
                      size: 35,
                      color: isLiked? Colors.red : Colors.black,
                    ),
                  ),

                  value.account!.positions!.toString().contains("student") ? InkWell(
                    onTap: () async{

                      DatabaseReference ref = FirebaseDatabase.instance.ref("users");

                      if(!isApplied){
                        isApplied = true;
                        await ref.update({
                          "${value.user_id}/Company": {
                            'idCompany': widget.company.id,
                            'accept': false,
                            'reject': false
                          },
                        });
                      }
                      else{
                        isApplied = false;
                        setState(() {
                        });
                        ref.child(
                          "${value.user_id}/Company"
                        ).remove();
                      }

                      setState(() {
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: isApplied ? Colors.red : Colors.green,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                          child: Text(
                              isApplied? "Cancel Apply" : "Apply Now"
                          )
                      ),
                    ),
                  ):
                      Container(),


                  value.account!.positions!.toString().contains("teacher") && !widget.company.is_verified!?
                  condistionCompany()
                      :
                      const SizedBox.shrink()

                ],
              )

            ],
          ),
        );
      }
    );
  }

  condistionCompany() {
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          InkWell(
            onTap: () async{

              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  text: 'Do you want to Accept ${widget.company.name}',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Colors.green,
                  onConfirmBtnTap: () async{
                    await ref?.update({
                      "${widget.company.id}/isVerified": true,
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

              await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  title: 'Do you want to Reject ${widget.company.name} company',
                  text: 'After reject this company automatically this account will be deleted',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Colors.green,
                  onConfirmBtnTap: () async{
                    await ref?.child('${widget.company.id}').remove();
                    Navigator.pop(context);
                  }
              );

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
}
