import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:st/Data/Data.dart';
import 'package:st/Screens/HomePage.dart';
import 'package:st/Screens/Login/Information.dart';
import 'package:st/StateManagement/AccountManagment.dart';
import 'package:st/models/Account.dart';

import '../Database/firebaseDatabase.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AccountManagement? accountManagement;

  @override
  void initState() {
    super.initState();

    accountManagement = AccountManagement();

  }


  var users = const {
    't@gmail.com': '12345',
    'hunter@gmail.com': 'hunter',
  };

  Duration get loginTime => const Duration(milliseconds: 2250);


  Future<String?> _authUser(LoginData data) {

    DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");

    // Map<String, dynamic>? values = {};


    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {

      ref.onValue.listen((event) {

        Map values = event.snapshot.value as Map;

        values.forEach((key, value) {
          Map datas = values[key];

          if(datas['email'] == data.name && datas['password'] == data.password){
            Provider.of<AccountManagement>(context, listen: false).setLoginAccount(key);
            print("Yes");

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) => const HomePage(),), (Route<dynamic> route) => false);
          }

        });

      });

      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => const HomePage(),
      // ));
      return null;

    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');

    signupData = data;

    account = Account(
        null,
        data.additionalSignupData?['Username'],
        data.name,
        null,
        null,
        data.additionalSignupData?['university'],
        data.additionalSignupData?['department'],
        data.additionalSignupData?['stage'], null, null,
        data.password,
       null,
       null,
      null
    );

    Provider.of<AccountManagement>(context, listen: false).setAccount(account);

    return Future.delayed(loginTime).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Information(),
      ));
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  SignupData? signupData;
  Account? account;

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountManagement>(
        builder: (context, accountProvider, child) {
        return FlutterLogin(
          title: 'SginIn',
          // logo: AssetImage('assets/images/ecorp-lightblue.png'),
          onLogin: _authUser,
          onSignup: _signupUser,
          onSubmitAnimationCompleted: () {
          },
          onRecoverPassword: _recoverPassword,

          additionalSignupFields: const [
            UserFormField(
                displayName: 'Username',
                keyName: 'Username',
                userType: LoginUserType.name
            ),
            UserFormField(
              displayName: 'university',
                keyName: 'university',
              userType: LoginUserType.text,
              icon: Icon(FontAwesomeIcons.buildingUser)
            ),
            UserFormField(
                displayName: 'department',
                keyName: 'department',
                userType: LoginUserType.text,
                icon: Icon(FontAwesomeIcons.buildingFlag)
            ),
            UserFormField(
                displayName: 'stage',
                keyName: 'stage',
                userType: LoginUserType.phone
            )
          ],
        );
      }
    );
  }
}
