import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:legal_doc_simplifier/views/homepage/home_providers.dart';
import 'package:legal_doc_simplifier/views/upload_screen/showDoubtDialog.dart';

const Color ourRed = Color(0xFFC10547);

IconButton doubtButton(WidgetRef ref) {
  return IconButton(
    icon: const Icon(Icons.quiz_outlined),
    color: const Color.fromARGB(255, 255, 117, 129),
    onPressed: () => showDoubtDialog(ref.context, ref),
  );
}
