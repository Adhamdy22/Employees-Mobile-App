import 'package:flutter/material.dart';
import 'package:network/ui/addemployee.dart';
import 'package:network/ui/employeeslist.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: ListView(children: [
          Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListTile(
                  title: Image.asset("assets/image/aswan.jpg", height: 200,
                    width: 200,),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ButtonTheme(
                      minWidth: 200,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("اضافة موظف",style: TextStyle(color: Colors.white,fontFamily: "arabic",fontSize: 15),),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddEmployee()),);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ButtonTheme(
                     minWidth: 200,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("استعلام عن موظف",style: TextStyle(color: Colors.white,fontFamily: "arabic",fontSize: 15),),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EmployeeList()),);
                      },
                    ),
                  ),
                  )
                ],

              ),
        ],)
    );
  }
}