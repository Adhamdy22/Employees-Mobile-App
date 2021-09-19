import 'package:flutter/material.dart';
import 'package:network/ui/admin_home.dart';
import 'package:network/ui/home.dart';
void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(accentColor: Colors.blue,
        brightness: Brightness.dark,
        primarySwatch: Colors.blue
        ),
        home: MyHomePage(),
      )
  );
}