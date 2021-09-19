import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:network/classes/emp_curd.dart';
import 'package:network/classes/employee.dart'; 
import 'package:fluttertoast/fluttertoast.dart';
class AddEmployee extends StatefulWidget {
  final Employee employee;

  const AddEmployee({Key key, this.employee}) : super(key: key);
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  String selectdepartment="";
  List<String> departments=[
  "التطبيقات",
  "الحسابات",
  "الادارة",
  "الدعم الفنى",
  "الصيانة والشبكات",
  "شبكات المرافق",
  ];
  TextEditingController employeename=new TextEditingController();
  TextEditingController department=new TextEditingController();
  TextEditingController job=new TextEditingController();
  TextEditingController dateofbirth=new TextEditingController();
  TextEditingController emplocation=new TextEditingController();
  TextEditingController phonenumber=new TextEditingController();
  TextEditingController nationalnumber=new TextEditingController();
  TextEditingController email=new TextEditingController();
  final key= GlobalKey<FormState>();
  addEmp(Employee emp) async{
    var msg=await SqlCurd().AddEmp(emp);
    Fluttertoast.showToast(msg:msg,toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        );
  }
  bool updatemood=false;
    updateEmp(Employee emp) async{
    var msg=await SqlCurd().updateEmp(emp);
    Fluttertoast.showToast(msg:msg,toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        );
  }
  @override
  void initState(){
    if(widget.employee!=null){
      employeename.text=widget.employee.employeename;
      department.text=widget.employee.department;
      job.text=widget.employee.job;
      dateofbirth.text=widget.employee.dateofbirth;
      emplocation.text=widget.employee.emplocation;
      phonenumber.text=widget.employee.phonenumber;
      nationalnumber.text=widget.employee.nationalnumber;
      email.text=widget.employee.email;
      updatemood=true;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title:Text(updatemood?
          "تعديل بيانات الموظف":
          "اضافة موظف",
          style: TextStyle(fontFamily: "arabic",fontSize: 20),
          )
           ),
           body: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Form(
               key: key,
               child: ListView(
                 children: [
                   TextFormField(
                    onFieldSubmitted: (String str)
                      {

                     },
                     onTap: ()
                     {

                    },
                    validator: (String fullName) {
                     if (fullName.length == 0) {
                      return 'ادخل الاسم كامل';
                     }
                     else if(fullName.length<=2){
                       return 'ادخل الاسم صحيح';
                     }
                      return null;
                     },

                     keyboardType: TextInputType.name,
                     controller:employeename,
                     decoration: InputDecoration(
                       labelText: "الاسم",labelStyle: TextStyle(fontFamily: "arabic",fontSize: 15),
                     ),
                   ),
                   SizedBox(height:10),
                   DropDownField(
                     controller: department,
                     labelText: "القسم",labelStyle:TextStyle(fontFamily: "arabic",fontSize: 15,color: Colors.white) ,
                     hintText: "القسم",hintStyle:TextStyle(fontFamily: "arabic",fontSize: 15,color: Colors.white) ,
                     enabled: true,
                     items: departments,
                     onValueChanged: (value){
                       setState(() {
                         selectdepartment=value;
                       });
                     }, 
                     itemsVisibleInDropdown: 5,      
                   ),
                   SizedBox(height:10),
                   TextFormField(
                     onFieldSubmitted: (String str)
                     {

                     },
                    onTap: ()
                    {

                    },
                validator: (String job1) {

                  if (job1.length == 0) {
                    return 'ادخل الوظيفة';
                  }
                  return null;
                },

                keyboardType: TextInputType.text,
                     controller:job,
                     decoration: InputDecoration(
                       labelText: "الوظيفة",labelStyle: TextStyle(fontFamily: "arabic",fontSize: 15),
                     ),
                   ),
                   SizedBox(height:10),
                   TextFormField(
                     onFieldSubmitted: (String str)
                     {

                     },
                     onTap: ()
                     {

                     },
                     validator: (String date1){
                      if(date1.length==0){
                        return "ادخل تاريخ الميلاد";
                      }
                      else if(date1.length<8){
                        return "ادخل تاريخ ميلاد صحيح";
                      }
                      return null;
                     },
                     keyboardType: TextInputType.datetime,
                     controller:dateofbirth,
                     decoration: InputDecoration(
                       labelText: "تاريخ الميلاد",labelStyle: TextStyle(fontFamily: "arabic",fontSize: 15),
                     ),
                   ),
                   SizedBox(height:10),
                   TextFormField(
                     onFieldSubmitted: (String str)
                    {

                    },
                    onTap: ()
                    {

                    },
                    validator: (String loc) {
                      if (loc.length == 0) {
                       return 'ادخل العنوان';
                     }
                      return null;
                   },
                     controller:emplocation,
                     decoration: InputDecoration(
                       labelText: "العنوان",labelStyle: TextStyle(fontFamily: "arabic",fontSize: 15),
                     ),
                   ),
                   SizedBox(height:10),
                   TextFormField(
                     onFieldSubmitted: (String str)
                {

                },
                onTap: ()
                {

                },
                validator: (String phonenumber)
                {
                  String pattern = r'(^(?:[+0]9)?[0-9]{11,11}$)';
                  RegExp regExp = new RegExp(pattern);
                  if (phonenumber.length == 0) {
                    return 'ادخل رقم الموبايل';
                  }
                  else if (!regExp.hasMatch(phonenumber)) {
                    return 'ادخال رقم موبايل صحيح';
                  }
                  else{
                    return null;
                  }
                },
                keyboardType: TextInputType.phone,
                     controller:phonenumber,
                     decoration: InputDecoration(
                       labelText: " رقم الموبايل",labelStyle: TextStyle(fontFamily: "arabic",fontSize: 15),
                     ),
                   ),
                   SizedBox(height:10),
                   TextFormField(
                     onFieldSubmitted: (String str)
                {

                },
                onTap: ()
                {

                },
                validator: (String id2)
                {
                  String pattern = r'(^(?:[+0]9)?[0-9]{14,14}$)';
                  RegExp regExp = new RegExp(pattern);
                  if (id2.length == 0) {
                    return 'ادخل الرقم القومى';
                  }
                  else if (!regExp.hasMatch(id2)) {
                    return 'ادخال رقم قومى صحيح';
                  }
                  else{
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                     controller:nationalnumber,
                     decoration: InputDecoration(
                       labelText: "الرقم القومى ",labelStyle: TextStyle(fontFamily: "arabic",fontSize: 15),
                     ),
                   ),
                   SizedBox(height:10),
                   TextFormField(
                     keyboardType: TextInputType.emailAddress,
                     controller:email,
                     decoration: InputDecoration(
                       labelText: "الايميل",labelStyle: TextStyle(fontFamily: "arabic",fontSize: 15),
                     ),
                   ),
                   SizedBox(height:10),
                   Column(
                     children: [
                       Center(
                         child: ElevatedButton(
                         onPressed: (){
                           if (key.currentState.validate()) {
                           if(updatemood){
                            Employee emp=Employee(
                              id:widget.employee.id,
                             employeename: employeename.text,
                             department: department.text,
                             job: job.text,
                             dateofbirth: dateofbirth.text,
                             emplocation: emplocation.text,
                             phonenumber: phonenumber.text,
                             nationalnumber: nationalnumber.text,
                             email: email.text
                           );
                           updateEmp(emp);
                           }
                           else{
                            Employee emp=Employee(
                             employeename: employeename.text,
                             department: department.text,
                             job: job.text,
                             dateofbirth: dateofbirth.text,
                             emplocation: emplocation.text,
                             phonenumber: phonenumber.text,
                             nationalnumber: nationalnumber.text,
                             email: email.text
                           );
                           addEmp(emp);
                           }
                         }
                          } ,
                         child: Text(updatemood?
                           "حفظ":
                           "تسجيل",
                           style: TextStyle(fontFamily: "arabic",fontSize: 15),
                           ),
                         ),
                       ),
                     ], 
                   ),
               ],),
             ),
           ),
    );
  }
}