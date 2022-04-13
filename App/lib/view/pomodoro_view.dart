import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PomodoroView extends StatefulWidget {
  const PomodoroView({Key? key}) : super(key: key);

  @override
  _PomodoroViewState createState() => _PomodoroViewState();
}

class _PomodoroViewState extends State<PomodoroView> {
  late Timer timer;
  double percent = 0;
  static int TimeInMinut = 25;
  int TimeInSec = TimeInMinut * 60;

  _StartTimer(){
    TimeInMinut = 25;
    int Time = TimeInMinut * 60;
    double SecPercent = (Time/100);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(Time > 0){
          Time--;
          if(Time % 60 == 0){
            TimeInMinut--;
          } if(Time % SecPercent == 0){
            if(percent < 1){
              percent += 0.01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          TimeInMinut = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff000000), Color(0xff393939)]),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 240.0,
                  lineWidth: 15.0,
                  backgroundColor: const Color(0xff363636),
                  progressColor: Colors.purple,
                    center: Column(
                      children: [
                        const SizedBox(height: 70),
                        Text(
                          "$TimeInMinut",
                          style: const TextStyle(color: Colors.white70, fontSize: 50),
                        ),
                        const Text(
                          "minutes",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    )
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: const [
                                    Text(
                                      'Study Timer',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white70),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '25',
                                      style: TextStyle(
                                          fontSize: 40, color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: const [
                                    Text(
                                      'Pause Time',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white70),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '5',
                                      style: TextStyle(
                                          fontSize: 40, color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 70),
                          child: ElevatedButton(
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text('Start Studying',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20
                                ),
                              ),
                            ),
                            onPressed: _StartTimer(),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.purple),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ))
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
