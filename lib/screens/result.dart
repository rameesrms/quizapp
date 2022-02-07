import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:quiz/pages/home.dart';

class Result extends StatefulWidget {
  final int score;
  const Result(this.score,{Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Column(mainAxisSize:MainAxisSize.min,

                children: [Text(widget.score>3?"C o n g r a t u l a t i o n s . . . ! !":"Better Luck Next Time..",style: TextStyle(color:widget.score>3?Colors.green:Colors.red,fontSize:10 ,fontWeight: FontWeight.normal),),
                  SizedBox(height: 30,),
                  Row(mainAxisSize:MainAxisSize.min,children:[Text("${widget.score}",style: TextStyle(fontSize:60,fontWeight: FontWeight.bold),),


                  Text("/10",style: TextStyle(fontSize:40 ,fontWeight: FontWeight.bold),)], ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 5,),
              child:Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.refresh_sharp,size: 50,),
            ) ,




                onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>HomePage()));

            },)
            ]),
          ),
    );
  }
}
