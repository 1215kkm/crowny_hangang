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
import 'screens/profile/user_profile_screen.dart';
import 'screens/chat/chat_room_screen.dart';
import 'screens/chat/create_room_screen.dart';
import 'screens/chat/dm_room_screen.dart';
import 'screens/map/hangang_map_screen.dart';
import 'models/user_model.dart';
import 'models/chat_model.dart';
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
        '/create-room': (_) => const CreateRoomScreen(),
        '/map': (_) => const HangangMapScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/user-profile') {
          final user = settings.arguments as UserModel;
          return MaterialPageRoute(builder: (_) => UserProfileScreen(user: user));
        }
        if (settings.name == '/chat-room') {
          final room = settings.arguments as MoimRoom;
          return MaterialPageRoute(builder: (_) => ChatRoomScreen(room: room));
        }
        if (settings.name == '/dm-room') {
          final name = settings.arguments as String? ?? '';
          return MaterialPageRoute(builder: (_) => DmRoomScreen(partnerName: name));
        }
        return null;
      },
    );
  }

  static void _noOp(int _) {}
}
