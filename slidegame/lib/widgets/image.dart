import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        )
      ),
    );
  }
}