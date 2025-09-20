import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:legal_doc_simplifier/views/homepage/home_providers.dart';

const Color ourRed = Color(0xFFC10547);

IconButton backToSimplifiedButton(WidgetRef ref) {
  return IconButton(
    onPressed: () {
      ref.read(currentPageProvider.notifier).state = 2;
    },
    icon: Icon(Icons.arrow_back_ios_new_rounded, color: ourRed, size: 30),
  );
}
