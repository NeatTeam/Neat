import 'package:flutter/material.dart';
import '../utils/constants.dart';

class WorkDay {
  final String name;
  bool isWorking;
  TimeOfDay startTime;
  TimeOfDay endTime;

  WorkDay({
    required this.name,
    this.isWorking = false,
    this.startTime = const TimeOfDay(hour: 9, minute: 0),
    this.endTime = const TimeOfDay(hour: 18, minute: 0),
  });
}

class CleanerScheduleScreen extends StatefulWidget {
  const CleanerScheduleScreen({Key? key}) : super(key: key);

  @override
  State<CleanerScheduleScreen> createState() => _CleanerScheduleScreenState();
}

class _CleanerScheduleScreenState extends State<CleanerScheduleScreen> {
  final List<WorkDay> _workDays = [
    WorkDay(name: 'Понедельник', isWorking: true),
    WorkDay(name: 'Вторник', isWorking: true),
    WorkDay(name: 'Среда', isWorking: true),
    WorkDay(name: 'Четверг', isWorking: true),
    WorkDay(name: 'Пятница', isWorking: true),
    WorkDay(name: 'Суббота'),
    WorkDay(name: 'Воскресенье'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'График работы',
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
              itemCount: _workDays.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _buildDayItem(_workDays[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _saveSchedule,
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

  Widget _buildDayItem(WorkDay day) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              day.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Switch(
              value: day.isWorking,
              onChanged: (value) {
                setState(() => day.isWorking = value);
              },
              activeColor: AppColors.primary,
            ),
          ),
          if (day.isWorking) ...[
            const Divider(color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Начало',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _selectTime(context, day, true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _formatTime(day.startTime),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Конец',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _selectTime(context, day, false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _formatTime(day.endTime),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, WorkDay day, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? day.startTime : day.endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              surface: AppColors.surface,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: AppColors.background,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          day.startTime = picked;
        } else {
          day.endTime = picked;
        }
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _saveSchedule() {
    // TODO: Save schedule
    Navigator.pop(context);
  }
} 