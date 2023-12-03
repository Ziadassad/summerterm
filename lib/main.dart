import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st/StateManagement/AccountManagment.dart';
import 'package:st/firebase_options.dart';

import 'Screens/HomePage.dart';
import 'Screens/Login/LoginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<AccountManagement>(create: (_) => AccountManagement()),
          ],
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  bool isLogin = false;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<AccountManagement>(

          builder: (BuildContext context, AccountManagement value, Widget? child) {

            print("ziad");
            print(value.isLogin);

            return value.isLogin! ? const HomePage() : const LoginPage();
          },
      )

    );
  }
}
