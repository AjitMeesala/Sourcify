import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sourcify/Models/user.dart';

class Api {
  static const baseUrl = "https://myapp-wloq.onrender.com/api";
  static const headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<http.Response> registerUser(User user) {
    return http.post(
      Uri. parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
  }
}
