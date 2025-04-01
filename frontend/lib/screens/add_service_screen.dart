import 'package:flutter/material.dart';
import '../utils/sample_data.dart';
import '../utils/constants.dart';
import '../models/service.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add Service'),
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: SampleData.services.length,
        itemBuilder: (context, index) {
          final service = SampleData.services[index];
          return Card(
            color: AppColors.darkGrey,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(
                Icons.cleaning_services,
                color: AppColors.primary,
                size: 32,
              ),
              title: Text(
                service.title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                service.description,
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.7),
                ),
              ),
              trailing: Text(
                '\$${service.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // TODO: Implement service addition logic
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
} 