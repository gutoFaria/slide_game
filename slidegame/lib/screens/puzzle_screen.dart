import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slidegame/widgets/grid_game.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  var number = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int numberOfMoves = 0;
  bool startGame = false;
  int cont = 0;
  static const countdownDuration = Duration(minutes: 0);
  Duration duration = const Duration();
  Timer? timer;

  bool isCountdown = true;

  @override
  void initState() {
    
    reset();
    super.initState();
  }

  onClick(index) {
    int emptyIndex = number.lastIndexOf(0);
    int previousIndex = index - 1;
    int nextIndex = index + 1;
    int previousRow = index - 4;
    int nextRow = index + 4;

    if (emptyIndex == previousIndex) {
      setState(() {
        number[previousIndex] = number[index];
        number[index] = 0;
        numberOfMoves++;
      });
    } else if (emptyIndex == nextIndex) {
      setState(() {
        number[nextIndex] = number[index];
        number[index] = 0;
        numberOfMoves++;
      });
    } else if (emptyIndex == previousRow) {
      setState(() {
        number[previousRow] = number[index];
        number[index] = 0;
        numberOfMoves++;
      });
    } else if (emptyIndex == nextRow) {
      setState(() {
        number[nextRow] = number[index];
        number[index] = 0;
        numberOfMoves++;
      });
    }

    checkWinner();
  }

  stopGame(){
    if(startGame == true){
      startGame = false;
    }
    return null;
  }

  bool isShorted(List numberList){
    int first = numberList.first;
    for(int i =0; i < numberList.length; i++){
      int nextNumber = numberList[i];
      if(first > nextNumber){
        return false;
      }
      first = numberList[i];
    }
    return true;
  }

  checkWinner(){
    bool isWinner = isShorted(number);
    if(isWinner){
       showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (_)=> AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      backgroundColor: Colors.green[100],
      actionsAlignment: MainAxisAlignment.center,
      title: const Text(
        'End Game',
        style: TextStyle(
            fontSize: 36, 
            color: Colors.white, 
            fontWeight: FontWeight.bold),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60))),
            onPressed: () {
              reset();
            },
            child: const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Text('Reset Game',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            )),
        
      ],
        ));
    }
  }


  reset() {
    if (isCountdown) {
      number.sort();
      cont = 0;
      numberOfMoves = 0;
      setState(() {
        duration = countdownDuration;
      });
    } else {
      setState(() {
        duration = const Duration();
      });
    }
  }

  addTime() {
    // contatodr regressar
    //final addSeconds = isCountdown ? -1 : 1;
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  startTime({bool resets = true}) {
    if (resets) {
      reset();
    }
    startGame = true;
    if(cont == 0){
      number.shuffle();
      cont = 1;
    }
    
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    stopGame();

    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover)),
          ),
          SafeArea(
              child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildTime(),
                              const SizedBox(
                                height: 10,
                              ),
                              buildButtons()
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                         Text(
                          'Moves: $numberOfMoves',
                          style:const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridGame(
                  number: number, 
                  onClick: startGame? onClick : stopTimer
                )
              ],
            ),
          ),
                  )),
            ],
          ))
        ],
      ),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTimeCard(time: hours, header: 'H'),
        buildTimeCard(time: minutes, header: 'M'),
        buildTimeCard(time: seconds, header: 'S')
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          ),
        ),
        const SizedBox(height: 8,),
        Text(header,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
        )
      ],
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                    } else {
                      startTime(resets: false);
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    isRunning ? 'STOP' : 'RESUME',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                width: 12,
              ),
              ElevatedButton(
                  onPressed: stopTimer,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: const Text('CANCEL',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold))),
            ],
          )
        : ElevatedButton(
            onPressed: () {
              startTime();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              'Start Game!',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ));
  }
}
