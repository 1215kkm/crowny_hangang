import 'package:flutter/material.dart';
import 'app/theme.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/main_shell.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/commerce/commerce_screen.dart';
import 'services/map_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MapService.initialize();
  runApp(const CrownyApp());
}

class CrownyApp extends StatelessWidget {
  const CrownyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '크라우니 한강',
      debugShowCheckedModeBanner: false,
      theme: CrownyTheme.themeData,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/auth': (_) => const AuthScreen(),
        '/main': (_) => const MainShell(),
        '/settings': (_) => const SettingsScreen(),
        '/commerce': (_) => const CommerceScreen(),
      },
    );
  }
}
