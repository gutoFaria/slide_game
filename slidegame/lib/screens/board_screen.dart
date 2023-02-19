import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slidegame/widgets/grid.dart';
import 'package:slidegame/widgets/image.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  var number = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int numberOfMoves = 0;
  @override
  void initState() {
    number.shuffle();
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
      print("Winner");
    }else{
      print("Not shotted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: ImageDisplay(
              imagePath: ('assets/logo.png'),
            ),
          ),
          Center(
            child: Text(
              'Puzzle',
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '$numberOfMoves Moves | 15 Tiles',
                style: GoogleFonts.roboto(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Grid(number: number, onClick: onClick)],
            ),
          ),
        ],
      ),
    );
  }
}
