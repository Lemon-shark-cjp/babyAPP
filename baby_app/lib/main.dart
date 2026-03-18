import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'screens/home_screen.dart';
import 'screens/record_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/health_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const BabyApp());
}

class BabyApp extends StatelessWidget {
  const BabyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: '宝宝成长记',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF8A80),
            primary: const Color(0xFFFF8A80),
            secondary: const Color(0xFF80CBC4),
          ),
          useMaterial3: true,
          fontFamily: 'NotoSansSC',
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const RecordScreen(),
    const ProfileScreen(),
    const HealthScreen(),
    const SettingsScreen(),
  ];

  final List<String> _titles = ['首页', '记录', '档案', '健康', '我的'];
  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.edit_note_outlined,
    Icons.folder_outlined,
    Icons.favorite_outline,
    Icons.person_outline,
  ];
  final List<IconData> _activeIcons = [
    Icons.home,
    Icons.edit_note,
    Icons.folder,
    Icons.favorite,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                final isActive = _currentIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFFFF8A80).withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isActive ? _activeIcons[index] : _icons[index],
                          color: isActive ? const Color(0xFFFF8A80) : Colors.grey,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _titles[index],
                          style: TextStyle(
                            color: isActive ? const Color(0xFFFF8A80) : Colors.grey,
                            fontSize: 11,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
