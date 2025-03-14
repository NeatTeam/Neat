import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/common/bottom_navbar.dart';

class ChatPreview {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String? avatarUrl;
  final bool unread;

  const ChatPreview({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    this.avatarUrl,
    this.unread = false,
  });
}

class Message {
  final String id;
  final String text;
  final DateTime time;
  final bool isFromMe;
  final String senderName;
  final String? avatarUrl;

  const Message({
    required this.id,
    required this.text,
    required this.time,
    required this.isFromMe,
    required this.senderName,
    this.avatarUrl,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatPreview> _chats = [
    ChatPreview(
      id: '1',
      name: 'Анна П.',
      lastMessage: 'Я буду у вас через 15 минут.',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 20)),
      unread: true,
    ),
    ChatPreview(
      id: '2',
      name: 'Мария С.',
      lastMessage: 'Спасибо за уборку!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatPreview(
      id: '3',
      name: 'Иван И.',
      lastMessage: 'До встречи завтра!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
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
          'Чаты',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _chats.length,
        separatorBuilder: (context, index) => const Divider(
          color: AppColors.divider,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(chat: chat),
                ),
              );
            },
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  chat.name[0],
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Row(
              children: [
                Text(
                  chat.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (chat.unread)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            subtitle: Text(
              chat.lastMessage,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              _formatTime(chat.lastMessageTime),
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${time.day}.${time.month}';
    } else if (difference.inHours > 0) {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      return '${time.minute} мин';
    }
  }
}

class ChatDetailScreen extends StatefulWidget {
  final ChatPreview chat;

  const ChatDetailScreen({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [
    Message(
      id: '1',
      text: 'Здравствуйте! Я буду вашим клинером сегодня.',
      time: DateTime.now().subtract(const Duration(minutes: 30)),
      isFromMe: false,
      senderName: 'Анна П.',
    ),
    Message(
      id: '2',
      text: 'Добрый день! Подскажите, пожалуйста, через сколько вы приедете?',
      time: DateTime.now().subtract(const Duration(minutes: 25)),
      isFromMe: true,
      senderName: 'Вы',
    ),
    Message(
      id: '3',
      text: 'Я буду у вас через 15 минут.',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
      isFromMe: false,
      senderName: 'Анна П.',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().toString(),
          text: _messageController.text,
          time: DateTime.now(),
          isFromMe: true,
          senderName: 'Вы',
        ),
      );
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.chat.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isFromMe) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  message.senderName[0],
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: message.isFromMe
                    ? AppColors.primary
                    : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(message.isFromMe ? 16 : 4),
                  bottomRight: Radius.circular(message.isFromMe ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!message.isFromMe)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        message.senderName,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Text(
                    message.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${message.time.hour}:${message.time.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: message.isFromMe
                          ? Colors.white.withOpacity(0.7)
                          : AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isFromMe) const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.attach_file,
                color: AppColors.primary,
              ),
              onPressed: () {
                // TODO: Implement file attachment
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Сообщение...',
                    hintStyle: TextStyle(
                      color: AppColors.secondaryText,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: AppColors.primary,
              ),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
} 