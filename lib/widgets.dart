import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legal_doc_simplifier/buttons.dart';
import 'package:legal_doc_simplifier/text_doc_from_json.dart';

const Color ourRed = Color(0xFFC10547);

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 120,
            bottom: 40,
          ),

          child: SvgPicture.asset(
            'assets/images/bgimage2.svg',
            height: MediaQuery.of(context).size.height * 0.4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "GET STARTED WITH A DOCUMENT NOW !!!",
            style: TextStyle(fontFamily: "ComingSoon", fontSize: 18),
          ),
        ),
        FirstPointCard(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [uploadButton(), addSpace(context, 0.25), cameraButton()],
        ),
      ],
    );
  }
}

SizedBox addSpace(BuildContext context, double percent) {
  return SizedBox(width: MediaQuery.of(context).size.width * percent);
}
