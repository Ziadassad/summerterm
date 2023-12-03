
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class firebaseDatabase{



  late DatabaseReference dbListPart = FirebaseDatabase.instance.ref().child("App");
  late Query getDB;

  Usersginup() async {

    // var firebaseApp = Firebase.app();
    // final rtdb = FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: 'https://database-e8780.firebaseio.com/');

    var map = {
      'email': 'ziad@gmail.com',
      'password': '1234',
      'level': ' student'
    };

    dbListPart.child("users").push().set(map);
  }

}