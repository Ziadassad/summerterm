
import 'package:st/Data/Data.dart';

class Account{

  String? id;

  String? name;
  String? email;
  String? gender;
  String? positions;
  String? university;
  String? department;
  String? stage;
  String? image;

  String? grades;
  String? password;


  String? idTeacher;
  Map<dynamic, dynamic>? company;

  String? info;


  Account(
      this.id,
      this.name,
      this.email,
      this.gender,
      this.positions,
      this.university,
      this.department,
      this.stage,
      this.image,
      this.grades,
      this.password,
      this.idTeacher,
      this.company,
      this.info);

  setPosition(String? positions){
    this.positions = positions;
  }

  factory Account.fromJson(Map<dynamic, dynamic> json) {

    return Account(
        json['id'],

        json['name'] ?? '',
        json['email'] ?? '',
        json['gender'] ?? '',
        json['position'] ?? '',
        json['university'] ??'',
        json['department'] ??'',
        json['stage'] ?? '',
        json['image']?? '',
        json['grades'] ?? '',
        json['password'] ?? false,
        json['idTeacher'] ?? '',
        json['Company'],
        json['info'] ?? ''
    );
  }

  Map<String, dynamic> toMap(){


    return {
      "name": name,
      "email": email,
      "gender": gender,
      "position": positions.toString(),
      "university": university,
      "stage": stage,
      "image": image,
      "grades": grades,
      "password": password,
      "idTeacher": idTeacher,
      "Company": company,
      "department": department,
      "info": info
    };
  }


}