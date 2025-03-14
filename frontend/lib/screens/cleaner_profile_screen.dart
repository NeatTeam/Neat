import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/cleaner_profile.dart';
import '../widgets/common/bottom_navbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'cleaner_stats_screen.dart';
import 'cleaner_schedule_screen.dart';
import 'cleaner_areas_screen.dart';
import 'cleaner_groups_screen.dart';
import 'wallet_screen.dart';
import 'chat_screen.dart';
import '../widgets/settings_section.dart';
import 'reviews_screen.dart';
import 'notification_settings_screen.dart';
import 'cleaner_settings_screen.dart';
import 'role_selection_screen.dart';

class CleanerProfileScreen extends StatefulWidget {
  final CleanerProfile profile;

  const CleanerProfileScreen({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<CleanerProfileScreen> createState() => _CleanerProfileScreenState();
}

class _CleanerProfileScreenState extends State<CleanerProfileScreen> {
  int _currentIndex = 3; // Profile tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.swap_horiz,
              color: AppColors.primary,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoleSelectionScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: AppColors.primary,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CleanerSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildMetricsSection(context),
            const SizedBox(height: 24),
            _buildEarningsCard(context),
            const SizedBox(height: 24),
            _buildCertificatesSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        isCleaner: true,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${widget.profile.firstName[0]}${widget.profile.lastName[0]}',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.profile.firstName} ${widget.profile.lastName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.profile.email,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem(
                icon: Icons.monetization_on,
                value: 'Income',
                label: 'Earnings',
                onTap: () => _showEarningsStats(context),
              ),
              _buildMetricItem(
                icon: Icons.cleaning_services,
                value: widget.profile.totalCleanings.toString(),
                label: 'Cleanings',
                onTap: () => _showCleaningsStats(context),
              ),
              _buildMetricItem(
                icon: Icons.star_border,
                value: widget.profile.rating.toString(),
                label: 'Rating',
                onTap: () => _showRatingStats(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCleaningsStats(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CleanerStatsScreen(initialTab: 1),
      ),
    );
  }

  void _showRatingStats(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CleanerStatsScreen(initialTab: 2),
      ),
    );
  }

  void _showEarningsStats(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CleanerStatsScreen(initialTab: 0),
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String value,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 36,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WalletScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Earnings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.profile.earnings.round()} ₽',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Available for withdrawal',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Withdraw',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificatesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Certificates',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.profile.certificates.length,
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.divider,
              height: 16,
            ),
            itemBuilder: (context, index) {
              final certificate = widget.profile.certificates[index];
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      certificate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return SettingsSection(
      items: [
        SettingsItem(
          icon: Icons.schedule,
          title: 'Schedule',
          subtitle: 'Mon-Fri, 9:00-18:00',
          color: Colors.blue,
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
          subtitle: 'Selected 3 areas',
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
          subtitle: 'Participant in 2 groups',
          color: Colors.orange,
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
          icon: Icons.star_border,
          title: 'Reviews',
          subtitle: '${widget.profile.reviews.length} reviews',
          color: Colors.amber,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewsScreen(reviews: widget.profile.reviews),
              ),
            );
          },
        ),
        SettingsItem(
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Enabled',
          color: Colors.red,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationSettingsScreen(),
              ),
            );
          },
        ),
        SettingsItem(
          icon: Icons.palette,
          title: 'App Theme',
          subtitle: 'Dark',
          color: Colors.purple,
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // TODO: Handle theme change
            },
            activeColor: AppColors.primary,
          ),
        ),
      ],
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;
    
    if (index == 2) { // Chat tab
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ),
      );
    } else {
      setState(() => _currentIndex = index);
      // TODO: Handle navigation for other tabs
    }
  }
} 