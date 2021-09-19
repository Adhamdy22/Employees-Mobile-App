
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network/classes/emp_curd.dart';
import 'package:network/classes/employee.dart';
import 'package:network/ui/addemployee.dart';
class EmployeeList extends StatefulWidget {
  
  @override
  _EmployeeListState createState() => _EmployeeListState();
}
class _EmployeeListState extends State<EmployeeList> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title:Text("قائمة الموظفين",style: TextStyle(fontSize: 20,fontFamily: "arabic"),),
          actions: [
            IconButton(
              icon: Icon(Icons.add), onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddEmployee()),);
              })
          ],
         ),
         body: RefreshIndicator(
                 
             onRefresh: (){ 
               Navigator.pushReplacement(
                 context,
                PageRouteBuilder(pageBuilder: (a,b,c)=>EmployeeList(),
                transitionDuration: Duration(seconds:0),
                ),
                );
                return Future.value(false);
              },
             child: FutureBuilder(
             future: SqlCurd().getEmp(),
             builder: (context,snapshot){
               if(snapshot.hasError){
                 print(snapshot.error);
               }
               return snapshot.hasData?
               ListView.builder(
                 itemCount: snapshot.data.length,
                 itemBuilder: (context,index){
                   List<Employee> empList=snapshot.data;
                   Employee emp=empList[index];
                   return EmployeesList(employee: emp,);
                 }):
                  Center(
                    child: CircularProgressIndicator(),
                  );
             }
             ),
         ),
    );
  }
}
class EmployeesList extends StatefulWidget {
  final Employee employee;

  const EmployeesList({Key key, this.employee}) : super(key: key);
  @override
  _EmployeesListState createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  bool showItemOptions=false;
  showOptions(){
    setState(() {
      showItemOptions=!showItemOptions;
    });
  }
  deleteEmp(Employee emp) async{
    await SqlCurd().deleteEmp(emp).then((value){
        Fluttertoast.showToast(
          msg:"DELETED",
          toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white, 
       );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => EmployeeList()), (
            route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading:CircleAvatar(backgroundColor:Colors.white,
          child: Text(widget.employee.employeename[0],style: TextStyle(fontSize: 15),   
          ),
        ),
          title:Text(widget.employee.employeename,style: TextStyle(fontSize: 20)),
          trailing: IconButton(icon: showItemOptions ? Icon(Icons.arrow_circle_up):Icon(Icons.arrow_circle_down), onPressed: ()=>showOptions()), 
        ),
        Visibility(
          visible: showItemOptions,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             IconButton(
               icon: Icon(Icons.info),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddEmployee(employee: widget.employee)),);
                }
             ),
             IconButton(
               icon: Icon(Icons.delete),
                onPressed: (){
                  deleteEmp(widget.employee);
                      
                })
          ],
          )
          )
      ]
    );
  }
}