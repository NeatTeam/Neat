import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/settings_section.dart';
import 'customer_stats_screen.dart';
import 'notification_settings_screen.dart';
import 'payment_methods_screen.dart';
import 'addresses_screen.dart';
import 'customer_reviews_screen.dart';

class CustomerSettingsScreen extends StatefulWidget {
  const CustomerSettingsScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSettingsScreen> createState() => _CustomerSettingsScreenState();
}

class _CustomerSettingsScreenState extends State<CustomerSettingsScreen> {
  bool _isDarkMode = true;
  bool _isNotificationsEnabled = true;
  String _selectedLanguage = 'Русский';

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
                  icon: Icons.analytics,
                  title: 'Statistics',
                  subtitle: 'Detailed cleaning information',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerStatsScreen(),
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
                  icon: Icons.payment,
                  title: 'Payment Methods',
                  subtitle: 'Visa •••• 4242',
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentMethodsScreen(),
                      ),
                    );
                  },
                ),
                SettingsItem(
                  icon: Icons.home,
                  title: 'Addresses',
                  subtitle: '2 addresses added',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressesScreen(),
                      ),
                    );
                  },
                ),
                SettingsItem(
                  icon: Icons.star_border,
                  title: 'Reviews',
                  subtitle: 'Your review history',
                  color: Colors.amber,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerReviewsScreen(),
                      ),
                    );
                  },
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
                'ИИ',
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
                  'Иван Иванов',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ivan@example.com',
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
          'Выберите язык',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('Русский'),
            _buildLanguageOption('English'),
            _buildLanguageOption('Español'),
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
          'Выйти из аккаунта',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Вы уверены, что хотите выйти из аккаунта?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Отмена',
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
              'Выйти',
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