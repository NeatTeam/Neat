import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Achievement {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int currentValue;
  final int targetValue;
  final double progress;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
    this.color = Colors.blue,
    required this.currentValue,
    required this.targetValue,
    required this.progress,
  });
}

class CleanerAchievementsScreen extends StatelessWidget {
  const CleanerAchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Achievement> _achievements = [
      Achievement(
        icon: Icons.star_border,
        title: 'Beginner',
        description: 'Complete your first 10 cleanings',
        progress: 0.6,
        currentValue: 6,
        targetValue: 10,
      ),
      Achievement(
        icon: Icons.workspace_premium,
        title: 'Professional',
        description: 'Complete 50 cleanings',
        progress: 0.8,
        currentValue: 40,
        targetValue: 50,
      ),
      Achievement(
        icon: Icons.cleaning_services,
        title: 'Cleaning Master',
        description: 'Complete 100 cleanings',
        progress: 0.3,
        currentValue: 30,
        targetValue: 100,
      ),
      Achievement(
        icon: Icons.grade,
        title: 'Perfect Rating',
        description: 'Maintain a 5-star rating for a month',
        progress: 0.9,
        currentValue: 27,
        targetValue: 30,
      ),
      Achievement(
        icon: Icons.window,
        title: 'Window Expert',
        description: 'Clean windows in 20 orders',
        progress: 0.5,
        currentValue: 10,
        targetValue: 20,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _achievements.length,
        itemBuilder: (context, index) {
          final achievement = _achievements[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: achievement.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  achievement.icon,
                  color: achievement.color,
                ),
              ),
              title: Text(
                achievement.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(achievement.description),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: achievement.progress,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(achievement.color),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${achievement.currentValue}/${achievement.targetValue}',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 