import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  late AccountManagement account;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    account = Provider.of<AccountManagement>(context, listen: false);

    if(account.account?.company != null && account.account!.company?['idCompany'] == widget.company.id){
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

                  Row(
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

                      const InkWell(
                        child: Icon(Icons.bookmark,
                          size: 35,),
                      )
                    ],
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
                        print("yesssss");
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
                      Container()

                ],
              )

            ],
          ),
        );
      }
    );
  }
}
