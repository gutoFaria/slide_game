import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Grid extends StatelessWidget {
    Grid({
    Key? key,
    required this.number,
    required this.onClick,
  }) : super(key: key);

  var number = [];
  Function onClick;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: MediaQuery.of(context).size.height*0.6,
      width: MediaQuery.of(context).size.width*0.7,
      child: GridView.builder(
        itemCount:number.length ,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4
        ),itemBuilder:(context,index){
          return number[index] !=0 ? GestureDetector(
            onTap: (){
              onClick(index);
            },
            child: Card(
              elevation: 10,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              child: Container(
                height: 50,
                width: 50,
                decoration:  BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(number[index].toString(),
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ),
            ),
          ):
          const SizedBox.shrink();
        } ,
      )
    );
  }
}
