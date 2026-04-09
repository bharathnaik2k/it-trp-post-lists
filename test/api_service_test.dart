import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:dummy/services/api_service.dart';
import 'dart:convert';
import 'package:dummy/models/post.dart';

void main() {
  group('ApiService Test', () {
    test('fetchPosts returns a list of posts on successful HTTP call', () async {
      final client = _MockClient((request) async {
        if (request.url.toString() == 'https://jsonplaceholder.typicode.com/posts') {
          return http.Response(json.encode([
            {'id': 1, 'title': 'Test Title', 'body': 'Test Body'}
          ]), 200);
        }
        return http.Response('Not Found', 404);
      });

      final apiService = ApiService(client: client);
      final posts = await apiService.fetchPosts();

      expect(posts, isA<List<Post>>());
      expect(posts.length, 1);
      expect(posts[0].title, 'Test Title');
    });

    test('fetchPosts throws an exception if the http call completes with an error', () async {
      final client = _MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final apiService = ApiService(client: client);

      expect(apiService.fetchPosts(), throwsException);
    });
  });
}

class _MockClient extends http.BaseClient {
  final Future<http.Response> Function(http.BaseRequest request) handler;

  _MockClient(this.handler);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await handler(request);
    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
      request: request,
    );
  }
}
