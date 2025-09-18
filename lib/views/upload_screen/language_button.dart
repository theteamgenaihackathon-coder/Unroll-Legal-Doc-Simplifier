import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

IconButton chooseLanguageButton() {
  return IconButton(
    onPressed: () {},
    // icon: Image.asset('assets/icons/language_icon.png', height: 50, width: 50),
    icon: Icon(
      Icons.g_translate_rounded,
      color: const Color.fromARGB(255, 255, 117, 129),
      fontWeight: FontWeight.bold,
    ),
  );
}
