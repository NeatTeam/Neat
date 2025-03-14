import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/settings_section.dart';

class NotificationSetting {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isEnabled;

  NotificationSetting({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isEnabled,
  });
}

class NotificationPreference {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool hasSwitch;
  final bool isEnabled;

  NotificationPreference({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.hasSwitch,
    this.isEnabled = false,
  });
}

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _newOrders = true;
  bool _orderUpdates = true;
  bool _payments = true;
  bool _reviews = true;
  bool _promotions = false;

  final List<NotificationSetting> _notificationSettings = [
    NotificationSetting(
      icon: Icons.assignment,
      title: 'New Orders',
      subtitle: 'Notifications about new orders',
      isEnabled: true,
    ),
    NotificationSetting(
      icon: Icons.update,
      title: 'Order Updates',
      subtitle: 'Changes in existing orders',
      isEnabled: true,
    ),
    NotificationSetting(
      icon: Icons.payment,
      title: 'Payments',
      subtitle: 'Payment notifications',
      isEnabled: true,
    ),
    NotificationSetting(
      icon: Icons.star,
      title: 'Reviews',
      subtitle: 'New reviews from clients',
      isEnabled: true,
    ),
    NotificationSetting(
      icon: Icons.local_offer,
      title: 'Promotions',
      subtitle: 'Special offers and deals',
      isEnabled: false,
    ),
  ];

  final List<NotificationPreference> _preferences = [
    NotificationPreference(
      icon: Icons.notifications,
      title: 'Notification Sound',
      subtitle: 'Default melody',
      hasSwitch: false,
    ),
    NotificationPreference(
      icon: Icons.vibration,
      title: 'Vibration',
      subtitle: 'Enabled',
      hasSwitch: true,
      isEnabled: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Notification Settings',
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
            SettingsSection(
              items: [
                SettingsItem(
                  icon: Icons.cleaning_services,
                  title: 'New Orders',
                  subtitle: 'Notifications about new orders',
                  color: Colors.blue,
                  trailing: Switch(
                    value: _newOrders,
                    onChanged: (value) => setState(() => _newOrders = value),
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItem(
                  icon: Icons.update,
                  title: 'Order Updates',
                  subtitle: 'Changes in existing orders',
                  color: Colors.orange,
                  trailing: Switch(
                    value: _orderUpdates,
                    onChanged: (value) => setState(() => _orderUpdates = value),
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItem(
                  icon: Icons.payment,
                  title: 'Payments',
                  subtitle: 'Payment notifications',
                  color: Colors.green,
                  trailing: Switch(
                    value: _payments,
                    onChanged: (value) => setState(() => _payments = value),
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItem(
                  icon: Icons.star,
                  title: 'Reviews',
                  subtitle: 'New reviews from clients',
                  color: Colors.amber,
                  trailing: Switch(
                    value: _reviews,
                    onChanged: (value) => setState(() => _reviews = value),
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItem(
                  icon: Icons.local_offer,
                  title: 'Promotions',
                  subtitle: 'Special offers and deals',
                  color: Colors.purple,
                  trailing: Switch(
                    value: _promotions,
                    onChanged: (value) => setState(() => _promotions = value),
                    activeColor: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              items: [
                SettingsItem(
                  icon: Icons.notifications_active,
                  title: 'Notification Sound',
                  subtitle: 'Default melody',
                  color: Colors.red,
                  onTap: () {
                    // TODO: Show sound picker
                  },
                ),
                SettingsItem(
                  icon: Icons.vibration,
                  title: 'Vibration',
                  subtitle: 'Enabled',
                  color: Colors.blue,
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // TODO: Handle vibration setting
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 