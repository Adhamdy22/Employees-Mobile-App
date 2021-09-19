import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:network/classes/emp_curd.dart';
import 'package:network/classes/emplogin.dart';
import 'package:network/ui/admin_home.dart';

import 'home.dart';
class Register extends StatefulWidget {
  final Login login;
  const Register({Key key, this.login}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _passwordVisible ;
  final key= GlobalKey<FormState>();
   registeremp(Login login) async{
    var msg=await SqlCurd().register(login);
    Fluttertoast.showToast(msg:msg,toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        );
  }
  @override
  void initState(){
    if(widget.login!=null){
    user.text=widget.login.empusername;
    pass.text=widget.login.emppassword;
    }
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
            color: Colors.black,
            child:Form(
              key:key,
              child:Column(
                children:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'انشاء حساب',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: "arabic"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String username){
                      if(username.length==0){
                        return "ادخل اسم المستخدم";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'اسم المستخدم',labelStyle:TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: "arabic"),
                      prefixIcon: Icon(Icons.person,color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    controller: user,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String pass){
                      String  pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                      RegExp regExp = new RegExp(pattern);
                       if(!regExp.hasMatch(pass)){
                        return " ادخل كلمة السر تتكون من 8 حروف وارقام معا";
                      }
                      return null;
                    },
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'كلمة السر',labelStyle:TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: "arabic"),
                      suffixIcon: IconButton(
                            icon: Icon(
                           // Based on passwordVisible state choose the icon
                           _passwordVisible
                          ? Icons.visibility
                        : Icons.visibility_off,
                         color: Colors.white,
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
                Column(
                  children: <Widget>[
                     Center(
                       child: MaterialButton(
                          color: Colors.blue,
                          child: Text('تسجيل',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          onPressed: () {
                            if (key.currentState.validate()) {
                             Login login=Login(
                              empusername: user.text,
                              emppassword: pass.text,
                            );
                            registeremp(login);
                            Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => AdminHome()), (
                                  route) => false);
                            }
                          },
                        ),
                     ),
                  ],
                ), 
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}