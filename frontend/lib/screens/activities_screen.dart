import 'package:flutter/material.dart';
import '../widgets/activity_card.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for upcoming activities
    final List<Map<String, dynamic>> upcomingActivities = [
      {
        'date': 'March 15, 2025, 10:00 AM',
        'type': 'Deep Cleaning',
        'address': '123 Main Street, Apt 4B',
        'status': 'Confirmed',
        'isFeedbackAvailable': true,
        'name': 'First lastna',
        'avatarUrl': 'https://via.placeholder.com/50',
      },
    ];

    // Sample data for past activities
    final List<Map<String, dynamic>> pastActivities = [
      {
        'date': 'February 15, 2025, 1:00 PM',
        'type': 'Standard Cleaning',
        'address': '123 Main Street, Apt 4B',
        'status': 'Completed',
        'feedback': 5, // 5 stars
        'name': 'First lastna',
        'avatarUrl': 'https://via.placeholder.com/50',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE4E2E2),
      appBar: AppBar(
        title: const Text(
          'Activities',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFF3B6F3F),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upcoming section
              const Text(
                'Upcoming:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292828),
                ),
              ),
              const SizedBox(height: 16),
              ...upcomingActivities.map((activity) => ActivityCard(
                    date: activity['date'],
                    type: activity['type'],
                    address: activity['address'],
                    status: activity['status'],
                    isFeedbackAvailable: activity['isFeedbackAvailable'],
                    name: activity['name'],
                    avatarUrl: activity['avatarUrl'],
                    feedback: null,
                  )),
              
              const SizedBox(height: 32),
              
              // Past section
              const Text(
                'Past:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292828),
                ),
              ),
              const SizedBox(height: 16),
              ...pastActivities.map((activity) => ActivityCard(
                    date: activity['date'],
                    type: activity['type'],
                    address: activity['address'],
                    status: activity['status'],
                    isFeedbackAvailable: false,
                    name: activity['name'],
                    avatarUrl: activity['avatarUrl'],
                    feedback: activity['feedback'],
                  )),
            ],
          ),
        ),
      ),
    );
  }
} 