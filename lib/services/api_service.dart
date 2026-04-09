import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class ApiService {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Post>> fetchPosts() async {
    final response = await client.get(
      Uri.parse('$baseUrl/posts'),
      headers: {
        'User-Agent': 'PostmanRuntime/7.28.4',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((post) => Post.fromJson(post as Map<String, dynamic>))
            .toList();
      } catch (e) {
        log('JSON Parsing Error: $e');
        throw Exception('JSON Parsing Error: $e');
      }
    } else {
      log('Failed to load posts: ${response.statusCode} - ${response.body}');
      throw Exception(
        'Failed to load posts: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
