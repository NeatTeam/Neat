import 'package:flutter/material.dart';
import '../widgets/chat_list_item.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration
    final List<Map<String, dynamic>> chats = [
      {
        'username': 'Username',
        'lastMessage': 'last message',
        'time': '12:03 PM',
        'avatarUrl': 'https://via.placeholder.com/50',
      },
      {
        'username': 'Username',
        'lastMessage': 'last message',
        'time': '12:03 PM',
        'avatarUrl': 'https://via.placeholder.com/50',
      },
      {
        'username': 'Username',
        'lastMessage': 'last message',
        'time': '12:03 PM',
        'avatarUrl': 'https://via.placeholder.com/50',
      },
      {
        'username': 'Username',
        'lastMessage': 'last message',
        'time': '12:03 PM',
        'avatarUrl': 'https://via.placeholder.com/50',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE4E2E2),
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFF3B6F3F),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return ChatListItem(
                    username: chat['username'],
                    lastMessage: chat['lastMessage'],
                    time: chat['time'],
                    avatarUrl: chat['avatarUrl'],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  print('View All pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: const Color(0xFF3B6F3F),
                  elevation: 0,
                  side: const BorderSide(
                    color: Color(0xFF3B6F3F),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(150, 50),
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 