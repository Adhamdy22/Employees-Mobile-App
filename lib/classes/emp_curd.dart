import 'dart:convert';

import 'package:network/classes/emplogin.dart';
import 'package:network/classes/employee.dart';
import 'package:http/http.dart' as http;
class SqlCurd{
  String serverurl="192.168.51.104";
  String phpPageURL="car_wash/myDB/emp_add.php";
  Future<String> AddEmp(Employee emp) async{
    String res;
    final response=await http.post(Uri.http(serverurl, phpPageURL),body: {
       "action":"insert",
       "employeename":emp.employeename,
       "department":emp.department,
       "job":emp.job,
       "dateofbirth":emp.dateofbirth,
       "emplocation":emp.emplocation,
       "phonenumber":emp.phonenumber,
       "nationalnumber":emp.nationalnumber,
       "email":emp.email
    });
    if(response.statusCode==200){
      res= response.body;
    }
    return res;
  }
  List<Employee> fromJson(String strjson){
    final data=jsonDecode(strjson);
    return List<Employee>.from(data.map((item)=>Employee.fromMap(item)));
  }
  Future<List<Employee>> getEmp() async{
    List<Employee> list;
    final response=await http.post(Uri.http(serverurl, phpPageURL),body: {
       "action":"getAll",
  });
  if(response.statusCode==200){
      list=fromJson(response.body);
  }
  return list;
 }
  Future<String> updateEmp(Employee emp) async{
    String res;
    final response=await http.post(Uri.http(serverurl, phpPageURL),body: {
       "action":"update",
       "id":emp.id,
       "employeename":emp.employeename,
       "department":emp.department,
       "job":emp.job,
       "dateofbirth":emp.dateofbirth,
       "emplocation":emp.emplocation,
       "phonenumber":emp.phonenumber,
       "nationalnumber":emp.nationalnumber,
       "email":emp.email
    });
    if(response.statusCode==200){
      res= response.body;
    }
    return res;
  }
  Future<String> deleteEmp(Employee emp) async{
    String res;
    final response=await http.post(Uri.http(serverurl, phpPageURL),body: {
       "action":"delete",
       "id":emp.id,
    });
    if(response.statusCode==200){
      res= response.body;
    }
    return res;
  }
  Future<String> register(Login login) async{
    String res;
    final response=await http.post(Uri.http(serverurl, phpPageURL),body: {
     "action":"register",
     "empusername":login.empusername,
     "emppassword":login.emppassword
    });
    if(response.statusCode==200){
      res= response.body;
    }
    return res;
  }
  Future<String> emplogin(Login login)async{
    String res;
    final response=await http.post(Uri.http(serverurl, phpPageURL),body: {
      "action":"login",
      "empusername":login.empusername,
     "emppassword":login.emppassword
  });
  if(response.statusCode==200){
      res= response.body;
    }
    else{
      print("shouldn't login ${response.body}");
    }
    
    return res;
 }
}
