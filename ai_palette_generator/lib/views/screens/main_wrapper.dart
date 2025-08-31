import 'package:flutter/material.dart';
import 'package:ai_palette_generator/views/screens/favorites_screen.dart';
import 'package:ai_palette_generator/views/screens/generate_screen.dart';
import 'package:ai_palette_generator/views/screens/home_screen.dart';
import 'package:ai_palette_generator/views/screens/settings_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const GenerateScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( 
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed, 
        selectedItemColor: Colors.blue, 
        unselectedItemColor: Colors.grey, 
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.palette_outlined), activeIcon: Icon(Icons.palette), label: 'إنشاء'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), activeIcon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}
