import 'package:flutter/material.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  String _preferredTimeSlot = 'Morning';
  bool _weekendAvailability = true;
  String _preferredLanguage = 'English';

  // Color scheme
  static const Color platinum = Color(0xFFE4E2E2);
  static const Color darkSpringGreen = Color(0xFF3B6F3F);
  static const Color raisinBlack = Color(0xFF292828);
  static const Color davysGray = Color(0xFF4A4A4A);
  static const Color cadetGray = Color(0xFF9E9E9E);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', 
          style: TextStyle(color: isDark ? platinum : Colors.white)),
        backgroundColor: darkSpringGreen,
      ),
      body: Container(
        color: isDark ? raisinBlack : platinum,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              elevation: 4,
              color: isDark ? davysGray : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? platinum : raisinBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(
                          color: isDark ? platinum : raisinBlack,
                        ),
                      ),
                      value: isDark,
                      activeColor: darkSpringGreen,
                      onChanged: (bool value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              color: isDark ? davysGray : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification Preferences',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? platinum : raisinBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(
                        'Enable Notifications',
                        style: TextStyle(
                          color: isDark ? platinum : raisinBlack,
                        ),
                      ),
                      value: _notificationsEnabled,
                      activeColor: darkSpringGreen,
                      onChanged: (bool value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              color: isDark ? davysGray : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cleaning Preferences',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? platinum : raisinBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Theme(
                      data: Theme.of(context).copyWith(
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: isDark ? platinum : davysGray,
                          ),
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _preferredTimeSlot,
                        dropdownColor: isDark ? davysGray : Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Preferred Time Slot',
                          labelStyle: TextStyle(
                            color: isDark ? platinum : davysGray,
                          ),
                        ),
                        items: ['Morning', 'Afternoon', 'Evening']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isDark ? platinum : raisinBlack,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _preferredTimeSlot = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(
                        'Weekend Availability',
                        style: TextStyle(
                          color: isDark ? platinum : raisinBlack,
                        ),
                      ),
                      value: _weekendAvailability,
                      activeColor: darkSpringGreen,
                      onChanged: (bool value) {
                        setState(() {
                          _weekendAvailability = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              color: isDark ? davysGray : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? platinum : raisinBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Theme(
                      data: Theme.of(context).copyWith(
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: isDark ? platinum : davysGray,
                          ),
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _preferredLanguage,
                        dropdownColor: isDark ? davysGray : Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Language',
                          labelStyle: TextStyle(
                            color: isDark ? platinum : davysGray,
                          ),
                        ),
                        items: ['English', 'Spanish', 'Portuguese']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isDark ? platinum : raisinBlack,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _preferredLanguage = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkSpringGreen,
                foregroundColor: platinum,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings saved successfully'),
                    backgroundColor: darkSpringGreen,
                  ),
                );
              },
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
} 