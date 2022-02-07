import 'dart:ui';
import 'package:quiz/model/questionmodel.dart';
import 'dart:convert';


import 'package:flutter/material.dart';

import 'package:quiz/screens/result.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic>? mapResponse;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _controller = PageController(initialPage: 0);
  bool isPressed = false;
  Color isTrue = Colors.green;
  Color isWrong = Colors.red;
  Color btnColor = Colors.amber;
  int score = 0;

  late Quiz quiz;
  List<Results>? results;

  Future apicall() async {
    http.Response response;
    response =
        await http.get(Uri.parse("https://opentdb.com/api.php?amount=10"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final quiz = Quiz.fromJson(mapResponse!);
        results = quiz.results;
      });
    }
    else{ CircularProgressIndicator();
  }
  }

  @override
  void initState() {
    apicall();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text("TRIVIA App".toUpperCase(),
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: (page) {
              setState(() {
                isPressed = false;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(results![index].question.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 23,
                          color: Colors.grey)),
                  Divider(
                    height: 5,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  for (int i = 0; i < results![index].allAnswers!.length; i++)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18.0, 1, 18, 1),
                        child: MaterialButton(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          focusColor: Colors.green,
                          splashColor: Colors.red,
                          onPressed: isPressed
                              ? () {}
                              : () {
                                  setState(() {
                                    isPressed = true;
                                  });
                                  if (results![index]
                                          .allAnswers![i]
                                          .toString() ==
                                      results![index]
                                          .correctAnswer
                                          .toString()) {
                                    score++;
                                  }
                                },
                          child: Text(
                            results![index].allAnswers![i].toString(),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 26,
                  ),
                  Divider(
                    height: 5,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                      onPressed: isPressed
                          ? index + 1 == 5
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Result(score)));
                                }
                              : () {
                                  _controller!.nextPage(
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeIn);
                                  setState(() {
                                    isPressed = false;
                                  });
                                }
                          : null,
                      child: Text(
                        "Next   ",
                        style: (TextStyle(fontSize: 25)),
                      ),
                    ),
                  ])
                ],
              );
            },
            itemCount: 10),
      ),
    );
  }
}
