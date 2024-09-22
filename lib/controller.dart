import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiController {
  static const String _baseUrl =
      "https://bangluru-house-price-prediction-eq08.onrender.com";

  Future<Map<String, dynamic>> predictHousePrice({
    required String location,
    required String sqft,
    required String bhk,
    required String bath,
  }) async {
    final String endpoint = '$_baseUrl/predict';

    final Map<String, dynamic> body = {
      'location': location,
      'total_sqft': sqft,
      'bhk': bhk,
      'bath': bath,
    };

    try {
      final http.Response response = await http
          .post(
            Uri.parse(endpoint),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 10)); // Add a timeout

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw HttpException(
          'Failed to load prediction data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw FetchDataException('Error fetching prediction: $e');
    }
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() => 'HttpException: $message';
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);

  @override
  String toString() => 'FetchDataException: $message';
}
