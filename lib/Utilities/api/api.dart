import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sourcify/Models/user.dart';
import 'package:sourcify/Models/user_cred.dart';

class Api {
  // static const baseUrl = "https://sourcify.onrender.com/api";
  static const baseUrl = "http://127.0.0.1:3000/api";
  static const headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<http.Response> registerUser(User user) {
    return http
        .post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    )
        .then((response) {
      if (response.statusCode == 201) {
        return response;
      } else {
        return response;
      }
    }).catchError((error) {
      throw Exception('Failed to register user.');
    });
  }

  Future<http.Response> loginUser(UserCred user) {
    return http
        .post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    )
        .then((response) {
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    }).catchError((error) {
      throw Exception('Failed to login user.');
    });
  }
}
