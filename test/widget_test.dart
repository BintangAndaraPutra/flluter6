// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:rpl_keamanan/config/dependency_injector.dart';
import 'package:rpl_keamanan/models/post.dart';
import 'package:rpl_keamanan/models/user.dart';
import 'package:rpl_keamanan/repositories/post_repository.dart';
import 'package:rpl_keamanan/repositories/user_repository.dart';
import 'package:rpl_keamanan/screens/post_list_screen.dart';
import 'package:rpl_keamanan/services/api_service.dart';

class _FakeUserRepository implements UserRepository {
  @override
  Future<List<User>> getUsers() async => [];

  @override
  Future<User> getUserById(int id) async => throw UnimplementedError();
}

class _FakePostRepository implements PostRepository {
  @override
  Future<List<Post>> getPosts() async => [
    const Post(userId: 1, id: 1, title: 'Post test', body: 'Isi post test'),
  ];
}

void main() {
  testWidgets('PostListScreen loads posts from the provided repository', (
    tester,
  ) async {
    final postRepository = _FakePostRepository();
    final injector = DependencyInjector(
      apiService: ApiService.withClient(
        MockClient((_) async => http.Response('[]', 200)),
        '',
      ),
      userRepository: _FakeUserRepository(),
      postRepository: postRepository,
    );

    await tester.pumpWidget(
      DependencyProvider(
        injector: injector,
        child: const MaterialApp(home: PostListScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Post test'), findsOneWidget);
    expect(find.text('Isi post test'), findsOneWidget);
  });
}
