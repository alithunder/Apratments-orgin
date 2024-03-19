import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000"; // Base URL of your backend

  Future<bool> signIn(String username, String password) async {
    final Uri url = Uri.parse('$baseUrl/userLogin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final userId = responseData['userId'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', userId);
      return true;
    } else {
      return false;
    }
  }


  // Function to submit a problem using the userId stored in shared_preferences
  Future<bool> submitProblem({
    required String title,
    required String description,
    required int userId,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    if (userId == null) {
      print('User ID not found. Please sign in.');
      return false;
    }

    final Uri url = Uri.parse('$baseUrl/addProblem');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'description': description,
        'userId': userId,
      }),
    );

    return response.statusCode == 200;
  }

  // Add user function remains unchanged
  Future<void> addUser({
    required String username,
    required String password,
    required String email,
    required String phone,
    required String role,
    String? building,
    String? unit,
    String? apartment,
  }) async {
    final Uri url = Uri.parse('$baseUrl/addUser');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
        'phone': phone,
        'role': role,
        'building': building,
        'unit': unit,
        'apartment': apartment,
      }),
    );

    if (response.statusCode == 200) {
      print('User added successfully');
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 400) {
        throw Exception(responseBody['message'] ?? 'Bad request');
      } else if (response.statusCode == 409) {
        throw Exception(responseBody['message'] ?? 'Conflict: Duplicate username.');
      } else {
        throw Exception('Failed to add user: Server error.');
      }
    }
  }

  // View users function remains unchanged
  Future<List<dynamic>> viewUsers() async {
    final Uri url = Uri.parse('$baseUrl/viewUsers');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users: ${response.body}');
    }
  }
}
