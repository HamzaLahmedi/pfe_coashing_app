import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/home/home_view.dart';
import 'package:pfe_coashing_app/home/live_view.dart';
import 'package:pfe_coashing_app/home/profile_view.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final _screens = [
    LiveView(),
    HomeView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            Icons.live_tv_outlined,
            color:Colors.white, // Use theme color
          ),
          Icon(
            Icons.home,
            color:Colors.white, // Use theme color
          ),
          Icon(
            Icons.person,
            color:Colors.white, // Use theme color
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: colorScheme.surface, // Use theme color
        color: AppColors.purpleColor, // Use theme color
        buttonBackgroundColor:AppColors.purpleColor, // Use theme color
        height: 60,
      ),
      body: _screens[_currentIndex],
    );
  }
}