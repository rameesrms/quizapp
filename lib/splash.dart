import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/pages/home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);




  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text("TRIVIA App".toUpperCase(),
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

    body:Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[


        Container(width: 200,height:200,child: Image(image: AssetImage("Assets/appstore.png"),),),

        FlatButton(
          child: Text("Let's Start", style: TextStyle(fontSize: 20.0),),
          color: Colors.amberAccent,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
          ,
          textColor: Colors.black,
          onPressed: (){ Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => HomePage()));
  },
        ),

] ),
    ),



    );
  }
}

