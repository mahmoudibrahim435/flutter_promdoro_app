// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterDownApp(),
    );
  }
}

class CounterDownApp extends StatefulWidget {
  const CounterDownApp({super.key});

  @override
  State<CounterDownApp> createState() => _CounterDownAppState();
}

class _CounterDownAppState extends State<CounterDownApp> {
  Timer? repeatedFunction;
  Duration duration = Duration(minutes: 25);

  startTimer() {
    repeatedFunction = Timer.periodic(Duration(seconds: 1), (qqqqqq) {
      setState(() {
        int newSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: newSeconds);
        if (duration.inSeconds == 0) {
          repeatedFunction!.cancel();
          setState(() {
            duration = Duration(minutes: 25);
            isRunning = false;
          });
        }
      });
    });
  }

  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Promodoro app",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 67, 106, 122),
      ),
      backgroundColor: Color.fromARGB(255, 52, 75, 84),
      // ignore: sized_box_for_whitespace
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            CircularPercentIndicator(
              progressColor: Color.fromARGB(255, 255, 85, 113),
              backgroundColor: Colors.grey,
              lineWidth: 8.0,
              percent: duration.inMinutes / 25,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 1000,
              radius: 135,
              center: Text(
                " ${duration.inMinutes.remainder(60).toString().padLeft(2, "0")} : ${duration.inSeconds.remainder(60).toString().padLeft(2, "0")} ",
                style: TextStyle(fontSize: 77, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 22,
            ),
            SizedBox(
              height: 55,
            ),
            isRunning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (repeatedFunction!.isActive) {
                            setState(() {
                              repeatedFunction!.cancel();
                            });
                          } else {
                            startTimer();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              Color.fromARGB(255, 197, 25, 97)),
                          padding: WidgetStateProperty.all(EdgeInsets.all(14)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9))),
                        ),
                        child: Text(
                          (repeatedFunction!.isActive) ? "Stop" : "Resume",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          repeatedFunction!.cancel();
                          setState(() {
                            duration = Duration(minutes: 25);
                            isRunning = false;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              Color.fromARGB(255, 197, 25, 97)),
                          padding: WidgetStateProperty.all(EdgeInsets.all(14)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9))),
                        ),
                        child: Text(
                          "CANCEL",
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimer();
                      setState(() {
                        isRunning = true;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Color.fromARGB(255, 25, 120, 197)),
                      padding: WidgetStateProperty.all(EdgeInsets.all(14)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9))),
                    ),
                    child: Text(
                      "Start studing",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
