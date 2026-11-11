import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/app_config.dart';
import 'config/dependency_injector.dart';
import 'screens/home_screen.dart';
import 'utils/logger.dart';

/// Entry point aplikasi.
///
/// Memuat konfigurasi dari file `.env` sebelum menjalankan aplikasi.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Muat file .env
  await dotenv.load(fileName: ".env");
  // Periksa konfigurasi
  if (!AppConfig.isConfigured()) {
    Logger.warning('Konfigurasi aplikasi belum lengkap.');
  }
  runApp(MyApp(dependencyInjector: DependencyInjector.instance));
}

class MyApp extends StatelessWidget {
  final DependencyInjector dependencyInjector;

  const MyApp({super.key, required this.dependencyInjector});

  @override
  Widget build(BuildContext context) {
    return DependencyProvider(
      injector: dependencyInjector,
      child: MaterialApp(
        title: 'RPL & Keamanan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
