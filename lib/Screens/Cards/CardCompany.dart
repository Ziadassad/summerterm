import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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

                  SizedBox(width: 10,),
                  Text(widget.company.name!, style: TextStyle(fontSize: 18),)
                ],
              ),
              // Text("sended", style: TextStyle(color: Colors.blueAccent),)
            ],

          ),

          SizedBox(height: 20,),

          Text("${widget.company.info}"),


          SizedBox(height: 20,),
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

                  InkWell(
                    child: Icon(Icons.bookmark,
                      size: 35,),
                  )
                ],
              ),

              InkWell(
                onTap: (){
                  isApplied = !isApplied;
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
              )

            ],
          )

        ],
      ),
    );
  }
}
