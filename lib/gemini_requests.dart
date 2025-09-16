import 'package:http/http.dart' as http;
import 'dart:io';

Future<void> sendRequestToCloudRun(File file) async {
  final url = Uri.parse('http://127.0.0.1:8000/simplify');
  // final headers = {
  //   'Content-Type': 'application/json',
  //   // 'Authorization': 'Bearer YOUR_IDENTITY_TOKEN', // Optional if public
  // };
  final request = http.MultipartRequest('POST', url)
    ..files.add(await http.MultipartFile.fromPath('file', file.path));

  // Optional: add headers if needed
  // request.headers['Authorization'] = 'Bearer YOUR_IDENTITY_TOKEN';

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    print('Gemini response: $responseBody');
  } else {
    print('Error: ${response.statusCode}');
  }
}
