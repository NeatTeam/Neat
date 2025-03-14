import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/settings_section.dart';
import 'notification_settings_screen.dart';
import 'wallet_screen.dart';
import 'cleaner_schedule_screen.dart';
import 'cleaner_areas_screen.dart';
import 'cleaner_groups_screen.dart';
import 'reviews_screen.dart';

class CleanerSettingsScreen extends StatefulWidget {
  const CleanerSettingsScreen({Key? key}) : super(key: key);

  @override
  State<CleanerSettingsScreen> createState() => _CleanerSettingsScreenState();
}

class _CleanerSettingsScreenState extends State<CleanerSettingsScreen> {
  bool _isDarkMode = true;
  bool _isNotificationsEnabled = true;
  bool _isAvailable = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileSection(),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Main',
              items: [
                SettingsItem(
                  icon: Icons.schedule,
                  title: 'Work Schedule',
                  subtitle: 'Mon-Fri, 9:00-18:00',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CleanerScheduleScreen(),
                      ),
                    );
                  },
                ),
                SettingsItem(
                  icon: Icons.location_on,
                  title: 'Work Areas',
                  subtitle: '3 areas selected',
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CleanerAreasScreen(),
                      ),
                    );
                  },
                ),
                SettingsItem(
                  icon: Icons.group,
                  title: 'Groups',
                  subtitle: 'Member of 2 groups',
                  color: Colors.indigo,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CleanerGroupsScreen(),
                      ),
                    );
                  },
                ),
                SettingsItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: _isNotificationsEnabled ? 'Enabled' : 'Disabled',
                  color: Colors.red,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationSettingsScreen(),
                      ),
                    );
                  },
                  trailing: Switch(
                    value: _isNotificationsEnabled,
                    onChanged: (value) {
                      setState(() => _isNotificationsEnabled = value);
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItem(
                  icon: Icons.account_balance_wallet,
                  title: 'Wallet',
                  subtitle: 'Balance and payment history',
                  color: Colors.amber,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WalletScreen(),
                      ),
                    );
                  },
                ),
                SettingsItem(
                  icon: Icons.star_border,
                  title: 'Reviews',
                  subtitle: 'Review history',
                  color: Colors.purple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReviewsScreen(reviews: []),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Status',
              items: [
                SettingsItem(
                  icon: Icons.work,
                  title: 'Availability',
                  subtitle: _isAvailable ? 'Available for orders' : 'Unavailable',
                  color: _isAvailable ? Colors.green : Colors.grey,
                  trailing: Switch(
                    value: _isAvailable,
                    onChanged: (value) => setState(() => _isAvailable = value),
                    activeColor: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Appearance',
              items: [
                SettingsItem(
                  icon: Icons.palette,
                  title: 'App Theme',
                  subtitle: _isDarkMode ? 'Dark' : 'Light',
                  color: Colors.purple,
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (value) => setState(() => _isDarkMode = value),
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItem(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: _selectedLanguage,
                  color: Colors.indigo,
                  onTap: () => _showLanguageDialog(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Security',
              items: [
                SettingsItem(
                  icon: Icons.lock,
                  title: 'Change Password',
                  color: Colors.blue,
                  onTap: () {
                    // TODO: Show change password dialog
                  },
                ),
                SettingsItem(
                  icon: Icons.security,
                  title: 'Two-Factor Authentication',
                  subtitle: 'Disabled',
                  color: Colors.green,
                  onTap: () {
                    // TODO: Show 2FA setup
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Support',
              items: [
                SettingsItem(
                  icon: Icons.help_outline,
                  title: 'Help',
                  subtitle: 'Frequently Asked Questions',
                  color: Colors.blue,
                  onTap: () {
                    // TODO: Show help section
                  },
                ),
                SettingsItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'Contact Support',
                  color: Colors.orange,
                  onTap: () {
                    // TODO: Show support chat
                  },
                ),
                SettingsItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'Version 1.0.0',
                  color: Colors.grey,
                  onTap: () {
                    // TODO: Show about section
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              items: [
                SettingsItem(
                  icon: Icons.logout,
                  title: 'Log Out',
                  color: Colors.red,
                  onTap: () => _showLogoutDialog(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'AP',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anna Peterson',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'anna@example.com',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: AppColors.primary,
            ),
            onPressed: () {
              // TODO: Show edit profile dialog
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Select Language',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('English'),
            _buildLanguageOption('Russian'),
            _buildLanguageOption('Spanish'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    final isSelected = _selectedLanguage == language;
    return ListTile(
      title: Text(
        language,
        style: TextStyle(
          color: isSelected ? AppColors.primary : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isSelected ? AppColors.primary : AppColors.secondaryText,
      ),
      onTap: () {
        setState(() => _selectedLanguage = language);
        Navigator.pop(context);
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Log Out',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.secondaryText,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Handle logout
              Navigator.pop(context);
            },
            child: Text(
              'Log Out',
              style: TextStyle(
                color: Colors.red[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 