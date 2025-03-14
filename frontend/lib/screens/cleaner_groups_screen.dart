import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Group {
  final String name;
  final String description;
  final int membersCount;
  bool isJoined;

  Group({
    required this.name,
    required this.description,
    required this.membersCount,
    this.isJoined = false,
  });
}

class CleanerGroupsScreen extends StatefulWidget {
  const CleanerGroupsScreen({Key? key}) : super(key: key);

  @override
  State<CleanerGroupsScreen> createState() => _CleanerGroupsScreenState();
}

class _CleanerGroupsScreenState extends State<CleanerGroupsScreen> {
  final List<Group> _groups = [
    Group(
      name: 'Профессионалы уборки',
      description: 'Группа для опытных клинеров',
      membersCount: 156,
      isJoined: true,
    ),
    Group(
      name: 'Новички',
      description: 'Группа для начинающих клинеров',
      membersCount: 89,
    ),
    Group(
      name: 'Премиум уборка',
      description: 'Группа для премиум-класса уборки',
      membersCount: 45,
      isJoined: true,
    ),
    Group(
      name: 'Экспресс уборка',
      description: 'Быстрая уборка за 2 часа',
      membersCount: 78,
    ),
    Group(
      name: 'Генеральная уборка',
      description: 'Группа для масштабных уборок',
      membersCount: 92,
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
          'Группы',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _groups.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final group = _groups[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            group.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${group.membersCount} участников',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          group.description,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _toggleGroup(group),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: group.isJoined
                                ? AppColors.surface
                                : AppColors.primary,
                            minimumSize: const Size(120, 36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: group.isJoined
                                  ? const BorderSide(color: AppColors.primary)
                                  : BorderSide.none,
                            ),
                          ),
                          child: Text(
                            group.isJoined ? 'Покинуть' : 'Присоединиться',
                            style: TextStyle(
                              color: group.isJoined
                                  ? AppColors.primary
                                  : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toggleGroup(Group group) {
    setState(() {
      group.isJoined = !group.isJoined;
    });
  }
} 