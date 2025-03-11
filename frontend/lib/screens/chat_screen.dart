import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String avatarUrl;

  const ChatScreen({
    super.key,
    required this.username,
    required this.avatarUrl,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Some text from the userawdkalwkdkakjw dkllwajdljadkawkjdjlkawjdkjlakwdlmakwkd mlamwkdmkamwmdlamw',
      'isMe': false,
      'time': '12:00 PM',
    },
    {
      'text': 'Some text from the userawdkalwkdkakjwd kllwajdljadkawkjdjlkawjdkjlakwdlmakwkd mlamwkdmkamwmdlamw',
      'isMe': true,
      'time': '12:01 PM',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4E2E2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B6F3F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Text(
              '[${widget.username}]',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color(0xFFCCEBCC), // Light green background
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.avatarUrl),
                radius: 20,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(
                  message['text'],
                  message['isMe'],
                  message['time'],
                );
              },
            ),
          ),
          
          // Message input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.attach_file,
                    color: Color(0xFF3B6F3F),
                    size: 28,
                  ),
                  onPressed: () {
                    // Handle attachment
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'TextField',
                      hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xFF3B6F3F),
                    size: 28,
                  ),
                  onPressed: () {
                    // Handle send message
                    if (_messageController.text.trim().isNotEmpty) {
                      // We'll implement this functionality later
                      print('Sending message: ${_messageController.text}');
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF3B6F3F) : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : const Color(0xFF292828),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF4A4A4A),
              ),
            ),
          ],
        ],
      ),
    );
  }
} 