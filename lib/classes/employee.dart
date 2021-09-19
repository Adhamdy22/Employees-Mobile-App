import 'package:flutter/cupertino.dart';

class Employee{
  String id;
  String employeename;
  String department;
  String job;
  String dateofbirth;
  String emplocation;
  String phonenumber;
  String nationalnumber;
  String email;
  Employee({
   this.id,
   @required this.employeename,
   @required this.department,
   @required this.job,
   @required this.dateofbirth,
   @required this.emplocation,
   @required this.phonenumber,
   @required this.nationalnumber,
   this.email
  });
  factory Employee.fromMap(Map<String,dynamic> map){
    return Employee(
      id: map["id"],
      employeename: map["employeename"],
       department:map["department"] ,
        job:map["job"],
        dateofbirth: map["dateofbirth"],
        emplocation: map["emplocation"],
        phonenumber: map["phonenumber"],
        nationalnumber: map["nationalnumber"],
        email: map["email"]
       );
  }
}