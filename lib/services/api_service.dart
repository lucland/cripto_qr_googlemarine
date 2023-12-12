import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/simple_logger.dart';
import 'local_storage_service.dart';

class ApiService {
  //Emulator:
  final String baseUrl = 'http://10.0.2.2:3000/api/v1';
  //Local:
  //final String baseUrl = 'http://localhost:3000/api/v1';
  //Device:
  //final String baseUrl = 'http://192.168.0.24:3000/api/v1';
  //
  final LocalStorageService localStorageService;

  ApiService(this.localStorageService);

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await _getHeaders(),
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );
    SimpleLogger.info('Response: ${response.body}');
    return _processResponse(response);
  }

  Future<http.Response> postLogin(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await _getHeaders(),
    );
    return _processResponse(response);
  }

  Future<Map<String, String>> _getHeaders() async {
    String? token = await localStorageService.getToken();

    return token != null
        ? {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
        : {
            'Content-Type': 'application/json',
          };
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      SimpleLogger.fine('Success: ${response.body}');
      return json.decode(response.body);
    } else {
      SimpleLogger.severe('Error: ${response.body}');
      throw Exception('Failed to process request: ${response.statusCode}');
    }
  }
}
