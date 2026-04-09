import 'package:flutter/material.dart';
import 'app/theme.dart';
import 'config/app_config.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/main_shell.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/commerce/commerce_screen.dart';
import 'screens/board/board_list_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'services/map_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load(theme: 'hangang');
  MapService.initialize();
  runApp(const CrownyApp());
}

class CrownyApp extends StatelessWidget {
  const CrownyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: CrownyTheme.themeData,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/auth': (_) => const AuthScreen(),
        '/main': (_) => const MainShell(),
        '/settings': (_) => const SettingsScreen(),
        '/commerce': (_) => const CommerceScreen(),
        '/board': (_) => const BoardListScreen(),
        '/search': (_) => const SearchScreen(),
        '/profile': (_) => const ProfileScreen(navIndex: 0, onNavTap: _noOp),
        // TODO: Step 2에서 추가
        // '/user-profile': (_) => const UserProfileScreen(),
        // '/chat-room': (_) => const ChatRoomScreen(),
        // '/create-room': (_) => const CreateRoomScreen(),
        // '/dm-room': (_) => const DmRoomScreen(),
        // '/map': (_) => const HangangMapScreen(),
      },
    );
  }

  static void _noOp(int _) {}
}
