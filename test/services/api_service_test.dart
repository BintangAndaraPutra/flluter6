import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:rpl_keamanan/services/api_service.dart';

void main() {
  test('getPosts requests JSONPlaceholder and parses posts', () async {
    Uri? requestedUri;
    final apiService = ApiService.withClient(
      MockClient((request) async {
        requestedUri = request.url;
        return http.Response(
          '[{"userId":1,"id":2,"title":"Test","body":"Post body"}]',
          200,
        );
      }),
      '',
    );

    final posts = await apiService.getPosts();
    apiService.dispose();

    expect(
      requestedUri.toString(),
      'https://jsonplaceholder.typicode.com/posts',
    );
    expect(posts, hasLength(1));
    expect(posts.single.userId, 1);
    expect(posts.single.id, 2);
    expect(posts.single.title, 'Test');
    expect(posts.single.body, 'Post body');
  });
}
