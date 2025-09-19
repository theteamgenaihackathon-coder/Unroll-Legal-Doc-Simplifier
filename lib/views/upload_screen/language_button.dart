import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/network/gemini_requests.dart';

class ChooseLanguageButton extends StatefulWidget {
  final Function(Map<String, dynamic>) onTranslationSuccess;

  const ChooseLanguageButton({super.key, required this.onTranslationSuccess});

  @override
  State<ChooseLanguageButton> createState() => _ChooseLanguageButtonState();
}

class _ChooseLanguageButtonState extends State<ChooseLanguageButton> {
  String _selectedLang = "english";
  bool _loading = false;

  final List<String> languages = [
    "english",
    "hindi",
    "tamil",
    "telugu",
    "malayalam",
    "kannada",
  ];

  Future<void> _translate(String lang) async {
    setState(() => _loading = true);

    try {
      final responseString = await translateSimplifiedRequest(lang);

      final Map<String, dynamic> decoded = jsonDecode(responseString);
      final simplifiedDoc =
          decoded["candidates"]?[0]?["content"]?["parts"]?[0]?["text"]; // adjust depending on backend

      if (simplifiedDoc != null) {
        final Map<String, dynamic> jsonDoc = jsonDecode(simplifiedDoc);
        widget.onTranslationSuccess(jsonDoc);
      }
    } catch (e) {
      print("Translation error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to translate document")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: _loading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(
              Icons.g_translate,
              color: Color.fromARGB(255, 255, 117, 129),
            ),
      onSelected: (String lang) {
        setState(() => _selectedLang = lang);
        _translate(lang);
      },
      itemBuilder: (context) {
        return languages.map((lang) {
          return PopupMenuItem<String>(
            value: lang,
            child: Text(lang[0].toUpperCase() + lang.substring(1)),
          );
        }).toList();
      },
    );
  }
}
