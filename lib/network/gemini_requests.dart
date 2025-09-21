// To send request from Flutter to Python FastAPI

// import 'dart:convert';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

Future<String> simplifyDocRequest(File file) async {
  final url = Uri.parse('http://10.0.2.2:8000/simplify');

  // ignore: unused_local_variable
  final headers = {'Content-Type': 'application/json'};

  final request = http.MultipartRequest('POST', url)
    ..files.add(await http.MultipartFile.fromPath('file', file.path));
  final streamedResponse = await request.send();

  final responseBody = await streamedResponse.stream.bytesToString();

  print("\n\n\n");
  print(responseBody);
  print("\n\n\n");
  return responseBody;
}

/// ✅ New: Request to translate the simplified document
Future<String> translateSimplifiedRequest(String targetLang) async {
  final url = Uri.parse(
    'http://10.0.2.2:8000/translate_simplified?target_lang=$targetLang',
  );

  final response = await http.post(url);

  if (response.statusCode == 200) {
    print("\n[Translation Response]\n${response.body}\n");
    return response.body;
  } else {
    throw Exception("Translation failed: ${response.body}");
  }
}

Future<String> fillRequest() async {
  final url = Uri.parse('http://10.0.2.2:8000/fill');

  final response = await http.post(url);

  if (response.statusCode == 200) {
    print("\n[Fill Response]\n${response.body}\n");
    return response.body;
  } else {
    throw Exception("Document Filling failed: ${response.body}");
  }
}

Future<String> sendDoubtRequest(String doubt) async {
  final url = Uri.parse('http://10.0.2.2:8000/doubt');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"doubt": doubt}),
  );

  if (response.statusCode == 200) {
    print("\n[Doubt Response]\n${response.body}\n");
    return response.body;
  } else {
    throw Exception("Doubt request failed: ${response.body}");
  }
}
