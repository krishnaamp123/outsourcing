import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenService {
  Future<Map<String, dynamic>> getToken() async {
    final url = Uri.parse('https://api.yourbackend.com/getToken');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        //isi
      }),
    );

    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get token');
    }
  }
}
