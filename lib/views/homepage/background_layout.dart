import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LayeredBackground extends StatelessWidget {
  // final Widget child;
  const LayeredBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset('assets/images/HomePageBG.svg'),
        // Image 1 - fills the whole screen
        // SvgPicture.asset("assets/images/bg.svg", fit: BoxFit.cover, width: 200),

        // Image 2 - centered
        // Align(
        //   alignment: Alignment.center,
        //   child: SvgPicture.asset(
        //     "assets/images/girl_image.svg",
        //     width: 200,
        //     height: 200,
        //     fit: BoxFit.contain,
        //   ),
        // ),

        // Image 3 - near top-left, but offset
        // Positioned(
        //   top: 40, // moves it down from the very top
        //   left: 30, // moves it right from the very left
        //   width: 120,
        //   child: SvgPicture.asset(
        //     "assets/images/Rectangle_111141407.svg",
        //     fit: BoxFit.contain,
        //   ),
        // ),

        // Foreground content
      ],
    );
  }
}
