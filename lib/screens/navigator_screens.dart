import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lemon_app_handler_new/screens/helper_screen.dart';

import 'history_screen.dart';
import 'home_screen.dart';

class NavigatorScreen extends ConsumerStatefulWidget {
  const NavigatorScreen({super.key});

  @override
  ConsumerState<NavigatorScreen> createState() => _NavigatorScreen();
}

class _NavigatorScreen extends ConsumerState<NavigatorScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const HelperScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 55.0,
              vertical: 15,
            ),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              padding: EdgeInsets.all(16),
              gap: 4,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.touch_app,
                  text: 'Helper',
                ),
                GButton(
                  icon: Icons.article,
                  text: 'History',
                ),
              ],
            ),
          ),
        ),
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)));
  }
}
