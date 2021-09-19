import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:network/classes/emp_curd.dart';
import 'package:network/classes/emplogin.dart';
import 'package:network/ui/admin_home.dart';
import 'package:network/ui/register.dart';
class MyHomePage extends StatefulWidget {
  final Login login;
  const MyHomePage({Key key, this.login}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime timeBackPressed=DateTime.now();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _passwordVisible ;
 Future<String> loginemp(Login login) async{
    var msg=await SqlCurd().emplogin(login);  
    Fluttertoast.showToast(msg:msg,toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        );
        print("here  $msg jjj ");
        return msg;
  }
  @override
  void initState(){
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () async {
              final differnce=DateTime.now().difference(timeBackPressed);
              // ignore: non_constant_identifier_names
              final ExitWarning=differnce>=Duration(seconds:2);
              timeBackPressed=DateTime.now();
              if(ExitWarning){
                final message="اضغط مرة اخرى للخروج";
                Fluttertoast.showToast(
                  msg: message,
                  fontSize: 18
                  );
                  return false;
              }
              else{
                Fluttertoast.cancel();
                return true;
              }
           },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'ISDT ASWAN',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Center(
          child: Container(
            height: 300,
            child: Card(
              color: Colors.lightBlue,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'تسجيل دخول',style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: "arabic"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'اسم المستخدم',labelStyle:TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: "arabic",color: Colors.black),
                        prefixIcon: Icon(Icons.person,color: Theme.of(context).primaryColorDark,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      controller: user,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'كلمة السر',labelStyle:TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: "arabic",color: Colors.black),
                        suffixIcon: IconButton(
                            icon: Icon(
                           // Based on passwordVisible state choose the icon
                           _passwordVisible
                          ? Icons.visibility
                        : Icons.visibility_off,
                         color: Theme.of(context).primaryColorDark,
                         ),
                         onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                          _passwordVisible = !_passwordVisible;
                           });
                        },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      controller: pass,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Center(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: MaterialButton(
                            color: Colors.pink,
                            child: Text('تسجيل الدخول',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            onPressed: () async{
                             Login login=Login(
                              empusername: user.text,
                              emppassword: pass.text,
                            );
                           var msg = await loginemp(login);
                          if(msg.contains("Success")) {
                            Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => AdminHome()), (
                                  route) => false);
                          } 
                            },
                          ),
                       ),
                      ),
                      Center(
                       child:
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: MaterialButton(
                            color: Colors.amber[100],
                            child: Text('انشاء حساب جديد',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            },
                          ),
                       ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}