import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Area {
  final String name;
  final String description;
  bool isSelected;

  Area({
    required this.name,
    required this.description,
    this.isSelected = false,
  });
}

class CleanerAreasScreen extends StatefulWidget {
  const CleanerAreasScreen({Key? key}) : super(key: key);

  @override
  State<CleanerAreasScreen> createState() => _CleanerAreasScreenState();
}

class _CleanerAreasScreenState extends State<CleanerAreasScreen> {
  final List<Area> _areas = [
    Area(
      name: 'Центральный район',
      description: 'Исторический центр города',
    ),
    Area(
      name: 'Адмиралтейский район',
      description: 'Близко к метро',
      isSelected: true,
    ),
    Area(
      name: 'Василеостровский район',
      description: 'Студенческий район',
      isSelected: true,
    ),
    Area(
      name: 'Петроградский район',
      description: 'Престижный район',
    ),
    Area(
      name: 'Приморский район',
      description: 'Новостройки',
      isSelected: true,
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
          'Районы работы',
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
              itemCount: _areas.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final area = _areas[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      area.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      area.description,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Switch(
                      value: area.isSelected,
                      onChanged: (value) {
                        setState(() => area.isSelected = value);
                      },
                      activeColor: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _saveAreas,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Сохранить',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveAreas() {
    // TODO: Save selected areas
    Navigator.pop(context);
  }
} 