import 'package:flutter/widgets.dart';

import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../services/api_service.dart';

class DependencyInjector {
  static final DependencyInjector instance = DependencyInjector();

  final ApiService apiService;
  final UserRepository userRepository;
  final PostRepository postRepository;

  DependencyInjector({
    ApiService? apiService,
    UserRepository? userRepository,
    PostRepository? postRepository,
  }) : apiService = apiService ?? ApiService(),
       userRepository =
           userRepository ?? UserRepositoryImpl(apiService: apiService),
       postRepository =
           postRepository ?? PostRepositoryImpl(apiService: apiService);
}

class DependencyProvider extends InheritedWidget {
  final DependencyInjector injector;

  const DependencyProvider({
    super.key,
    required this.injector,
    required super.child,
  });

  static DependencyInjector of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<DependencyProvider>();
    if (provider == null) {
      throw StateError('DependencyProvider tidak ditemukan di widget tree.');
    }
    return provider.injector;
  }

  @override
  bool updateShouldNotify(DependencyProvider oldWidget) =>
      injector != oldWidget.injector;
}
