import 'package:http/http.dart' as http;
import 'dart:io';

Future<String> simplifyDoc(File file) async {
  final url = Uri.parse('http://10.0.2.2:8000/simplify');
  // final headers = {
  //   'Content-Type': 'application/json',
  //   // 'Authorization': 'Bearer YOUR_IDENTITY_TOKEN', // Optional if public
  // };
  final request = http.MultipartRequest('POST', url)
    ..files.add(await http.MultipartFile.fromPath('file', file.path));

  // Optional: add headers if needed
  // request.headers['Authorization'] = 'Bearer YOUR_IDENTITY_TOKEN';

  final streamedResponse = await request.send();
  // print(response);

  final responseBody = await streamedResponse.stream.bytesToString();
  print(responseBody);

  return responseBody;
  // if (responseBody.statusCode == 200) {
  //   final responseBody = await response.stream.bytesToString();
  //   return responseBody;
  //   print('Gemini response: $responseBody');
  // } else {
  //   print('Error: ${response.statusCode}');
  //   return '{}';
  // }
}
