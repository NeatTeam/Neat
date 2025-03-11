import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';

class ActivityCard extends StatelessWidget {
  final String date;
  final String type;
  final String address;
  final String status;
  final bool isFeedbackAvailable;
  final String name;
  final String avatarUrl;
  final int? feedback;

  const ActivityCard({
    super.key,
    required this.date,
    required this.type,
    required this.address,
    required this.status,
    required this.isFeedbackAvailable,
    required this.name,
    required this.avatarUrl,
    this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF292828),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Type: $type',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF292828),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Address: $address',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF292828),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Status: $status',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF292828),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Feedback section
                  if (feedback != null) ...[
                    Row(
                      children: [
                        const Text(
                          'Feedback: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF292828),
                          ),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: index < feedback! 
                                  ? const Color(0xFFFFD700) // Gold color for filled stars
                                  : const Color(0xFF9E9E9E), // Grey for empty stars
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else if (isFeedbackAvailable) ...[
                    TextButton(
                      onPressed: () {
                        // Handle leave feedback action
                        print('Leave feedback for $date');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: const Color(0xFF3B6F3F),
                      ),
                      child: const Text(
                        'Leave feedback',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Person avatar and name - clickable to open chat
            GestureDetector(
              onTap: () {
                // Navigate to chat screen when avatar or name is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      username: name,
                      avatarUrl: avatarUrl,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCEBCC), // Light green background
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF292828),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 