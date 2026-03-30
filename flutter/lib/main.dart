import 'package:flutter/material.dart';
import 'app/theme.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/main_shell.dart';

void main() {
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
      },
    );
  }
}
