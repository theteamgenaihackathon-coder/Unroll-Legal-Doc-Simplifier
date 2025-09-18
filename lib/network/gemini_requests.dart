// To send request from Flutter to Python FastAPI

// import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

Future<String> simplifyDocRequest(File file) async {
  final url = Uri.parse('http://10.0.2.2:8000/simplify');

  // ignore: unused_local_variable
  final headers = {'Content-Type': 'application/json'};

  final request = http.MultipartRequest('POST', url)
    ..files.add(await http.MultipartFile.fromPath('file', file.path));
  final streamedResponse = await request.send();
  // final stream = streamedResponse.stream.transform(const Utf8Decoder());
  // await for (final chunk in stream) {
  //   yield chunk; // Emit each chunk as it arrives
  // }

  final responseBody = await streamedResponse.stream.bytesToString();

  print("\n\n\n");
  print(responseBody);
  print("\n\n\n");
  return responseBody;
}
