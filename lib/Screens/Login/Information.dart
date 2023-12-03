import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:st/Data/Data.dart';
import 'package:st/Screens/HomePage.dart';
import 'package:st/StateManagement/AccountManagment.dart';
import 'package:st/models/Account.dart';

import '../../FilePiker/ImagePiker.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {

  Positions? positions;
  String? gender;

  List<String> genders = ['Male', 'Female'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: OverlayLoaderWithAppIcon(
        isLoading: _isLoading,
        overlayBackgroundColor: Colors.black,
        circularProgressColor: const Color(0xff670099),
        appIcon: const Icon(FontAwesomeIcons.person),
        child: Consumer<AccountManagement>(

          builder: (context, account, child) {
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 100),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Complete Your Information", style: TextStyle(fontSize: 20),),

                    SizedBox(
                      width: 170,
                      height: 170,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: 150,
                              height: 150,
                              padding: const EdgeInsets.only(),
                              decoration: BoxDecoration(
                                  color: const Color(0xffe3e3e3),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.30),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]),
                              child: imageProfile != null
                                  ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                    imageProfile!,
                                    fit: BoxFit.fill,
                                  ))
                                  : const Icon(
                                Icons.account_circle_outlined,
                                size: 80,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.blueAccent,
                              child: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    ShowDialig(context, 1);
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo_rounded,
                                    size: 22,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 50,),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 55,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      value: gender,
                      hint: const Center(child: Text("Select your gender", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.white),)),
                      underline: const SizedBox(),
                      onChanged: (String? value) {
                        print(value);
                        setState(() {
                          gender = value!;
                        });
                      },
                      alignment: Alignment.bottomRight,
                      borderRadius: BorderRadius.circular(15),
                      items: genders.map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          // style: TextStyle(color: Colors.white),
                        ),
                      )
                      ).toList(),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 55,
                    child: DropdownButton<Positions>(
                      isExpanded: true,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      value: positions,
                      hint: const Center(child: Text("Select position", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.white),)),
                      underline: const SizedBox(),
                      onChanged: (Positions? value) {
                        print(value);
                        setState(() {
                          positions = value;
                        });
                      },
                      alignment: Alignment.bottomRight,
                      borderRadius: BorderRadius.circular(15),
                      items: Positions.values.map((item) => DropdownMenuItem(

                        value: item,
                        child: Text(
                          item.toString().split('.').last,
                          // style: TextStyle(color: Colors.white),
                        ),
                      )
                      ).toList(),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: InkWell(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

                        myAccount = account.account;
                        myAccount?.gender = gender;
                        myAccount?.setPosition(positions.toString());

                        SaveInformations();

                      },
                      child: Center(child: Text("Finish", style: TextStyle(fontSize: 18, color: Colors.white),)),
                    ),
                  )

                ],
              ),
            );
          }
        ),
      ),
    );
  }

  bool _isLoading=false;

  Account? myAccount;

  FirebaseDatabase database = FirebaseDatabase.instance;

  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");

  SaveInformations() async{

    setState(() {_isLoading=true;});

    var image = await uploadImage();

    print(image);

    if(image != false){
      myAccount?.image = image.toString();
    }

    await ref.push().set(myAccount?.toMap());




    final DataSnapshot snapshot = await ref.get();


    if (snapshot.exists) {


      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Create Account Successfully!',
      );

      ref.onValue.listen((event) {

        Map values = event.snapshot.value as Map;

        values.forEach((key, value) {
          Map datas = values[key];

          if(datas['email'] == myAccount?.email && datas['password'] == myAccount?.password){
            Provider.of<AccountManagement>(context, listen: false).setLoginAccount(key);
            Provider.of<AccountManagement>(context, listen: false).setAccount(myAccount);
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

          }
        });

      });


    } else {

      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Not Successfully',
        text: 'Sorry, something went wrong',
      );
    }

    setState(() {_isLoading=false;});
  }


  Future uploadImage() async {
    if (imageProfile != null) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("images/${DateTime.now()}.png");
        UploadTask uploadTask = ref.putFile(imageProfile!);
        await uploadTask.whenComplete(() => print('File Uploaded'));
        final String downloadUrl = await ref.getDownloadURL();
        return downloadUrl;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }


  File? imageProfile;
  getImage(int i) async {
    File? image = null;

    bool back = false;

    // if (imageType != 1) back = true;
    if (i == 0) {
      image = await SelectMedia().getSingleImage(context, ImageSource.camera, back);
      print(image);
    } else {
      image = await SelectMedia().getSingleImage(context, ImageSource.gallery, back);
    }
    final temporary = image;
    setState(() {
      imageProfile = temporary;

    });
    Navigator.of(context).pop();
    // return temporary;
  }

  Future<void> ShowDialig(BuildContext context, int imageType) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text("Chioce Your Image")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white24)),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.add_a_photo_rounded,
                          size: 100,
                        ),
                        onTap: () {
                          getImage(0);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white24)),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.add_photo_alternate,
                          size: 110,
                        ),
                        onTap: () {
                          getImage(1);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

}
