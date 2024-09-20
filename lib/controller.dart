// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiController {
  Future<Map<String, dynamic>> predictHousePrice({
    required String location,
    required String sqft,
    required String bhk,
    required String bath,
  }) async {
    const String url = "http://192.168.87.199:5000/predict";

    final Map<String, String> body = {
      'location': location,
      'total_sqft': sqft,
      'bhk': bhk,
      'bath': bath,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(
            'Failed to load prediction data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching prediction: $e');
    }
  }
}
