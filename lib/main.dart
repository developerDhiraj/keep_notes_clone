import 'package:flutter/material.dart';
import 'package:keep_notes_clone/home.dart';
import 'package:keep_notes_clone/services/login_info.dart';

import 'login.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogIn = false;

  getLoggedInState() async{
    await LocalDataSaver.getLogData().then((value){
      setState((){
        isLogIn = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: isLogIn ? Home(): Login(),
    );
  }
}