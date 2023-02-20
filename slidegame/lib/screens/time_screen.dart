import 'dart:async';

import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  static const countdownDuration = Duration(minutes: 0);
  Duration duration = const Duration();
  Timer? timer;

  bool isCountdown = true;

  @override
  void initState() {
    //startTime();
    reset();
    super.initState();
  }

  reset(){
      if(isCountdown){
      setState(() {
        duration = countdownDuration;
      });
    }else{
      setState(() {
        duration = const Duration();
      });
    }
  }

  addTime(){
    // contatodr regressar
    //final addSeconds = isCountdown ? -1 : 1;
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if(seconds < 0){
        timer?.cancel();
      }else{
        duration = Duration(seconds: seconds);
      }

      
    });


    //contador de adicionar
    // const addSeconds = 1;
    // setState(() {
    //   final seconds = duration.inSeconds + addSeconds;

    //   duration = Duration(seconds: seconds);
    // });
  }

  startTime({bool resets = true}){
    if(resets){
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  stopTimer({bool resets = true}){
    if(resets){
      reset();
    }

    setState(() {
      timer?.cancel();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        buildTime(),
        const SizedBox(height: 80,),
        buildButtons()
      ],
    ),);
  }

  Widget buildTime(){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           buildTimeCard(
            time: hours, header:'HOURS'
          ),
          buildTimeCard(
            time: minutes, header:'MINUTES'
          ),
          const SizedBox(width: 8),
          buildTimeCard(
            time: seconds, header:'SECONDS'
          )
        ],
      );
  }

  Widget buildTimeCard({required String time, required String header}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 72
            ),
          ),
        ),
        const SizedBox(height: 24,),
        Text(header)
      ],
    );
  }

  Widget buildButtons(){
    final isRunning = timer == null? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted ?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){
              if(isRunning){
                stopTimer(resets: false);
              }else{
                startTime(resets:false);
              }
            }, 
            child:Text(isRunning? 'STOP' : 'RESUME')
          ),
          const SizedBox(width: 12,),
          ElevatedButton(
            onPressed: stopTimer, 
            child: const Text('CANCEL')
          ),
        ],
      )
      : 
      ElevatedButton(
        onPressed: (){
          startTime();
        }, 
        child: const Text('Start Timer!',
        style: TextStyle(color: Colors.black),)
      );
  }
}