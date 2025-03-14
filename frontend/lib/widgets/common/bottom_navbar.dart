import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../screens/home_screen.dart';
import '../../screens/services_screen.dart';
import '../../screens/activity_screen.dart';
import '../../screens/user_profile_screen.dart';
import '../../screens/cleaner_profile_screen.dart';
import '../../screens/chat_screen.dart';
import '../../screens/wallet_screen.dart';
import '../../utils/sample_data.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final bool isCleaner;
  final Function(int)? onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    this.isCleaner = false,
    this.onTap,
  }) : super(key: key);

  void _handleNavigation(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }

    if (index == currentIndex) return;

    Widget? nextScreen;
    
    if (isCleaner) {
      switch (index) {
        case 0:
          nextScreen = CleanerProfileScreen(profile: SampleData.cleanerProfile);
          break;
        case 1:
          // Orders screen for cleaner
          break;
        case 2:
          nextScreen = const ChatScreen();
          break;
        case 3:
          nextScreen = CleanerProfileScreen(profile: SampleData.cleanerProfile);
          break;
      }
    } else {
      switch (index) {
        case 0:
          nextScreen = HomeScreen(
            services: SampleData.services,
            promotions: SampleData.promotions,
          );
          break;
        case 1:
          nextScreen = ServicesScreen(
            services: SampleData.services,
            selectedIndex: index,
          );
          break;
        case 2:
          nextScreen = const ActivityScreen();
          break;
        case 3:
          nextScreen = UserProfileScreen(profile: SampleData.userProfile);
          break;
      }
    }

    if (nextScreen != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextScreen!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _handleNavigation(context, index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        selectedLabelStyle: AppTextStyles.caption,
        unselectedLabelStyle: AppTextStyles.caption,
        items: isCleaner
            ? const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_outlined),
                  activeIcon: Icon(Icons.list_alt),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_outlined),
                  activeIcon: Icon(Icons.chat),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ]
            : const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cleaning_services_outlined),
                  activeIcon: Icon(Icons.cleaning_services),
                  label: 'Services',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  activeIcon: Icon(Icons.calendar_today),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
      ),
    );
  }
} 