import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Error en la petición');
    }

    return jsonDecode(response.body);
  }
}
