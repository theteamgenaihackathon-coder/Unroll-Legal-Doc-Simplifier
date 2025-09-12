import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legal_doc_simplifier/buttons.dart';

const Color ourRed = Color(0xFFC10547);

AppBar myAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    surfaceTintColor: Colors.transparent,
    elevation: 2,
    shadowColor: Colors.black.withAlpha(200),
    leading: menuButton(),
    actions: [accountButton()],
    title: Text(""),
    centerTitle: true,
  );
}

Widget myBody(BuildContext context) {
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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [uploadButton(), addSpace(context, 0.25), cameraButton()],
      ),
    ],
  );
}

SizedBox addSpace(BuildContext context, double percent) {
  return SizedBox(width: MediaQuery.of(context).size.width * percent);
}
