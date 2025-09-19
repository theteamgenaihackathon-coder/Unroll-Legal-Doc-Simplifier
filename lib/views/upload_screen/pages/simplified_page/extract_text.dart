// Get the usable part from the Json response

import 'dart:convert';

String extractTextFromJson(String jsonString) {
  final decoded = jsonDecode(jsonString);

  final candidates = decoded['candidates'];
  if (candidates is List && candidates.isNotEmpty) {
    final content = candidates[0]['content'];
    final parts = content['parts'];
    if (parts is List && parts.isNotEmpty) {
      final text = parts[0]['text'];
      if (text is String) {
        return text;
      }
    }
  }

  return 'No text found';
}
