import 'package:flutter/material.dart';
import '../utils/constants.dart';

class EcoOption {
  final String name;
  final String description;
  final int price;
  bool isSelected;

  EcoOption({
    required this.name,
    required this.description,
    required this.price,
    this.isSelected = false,
  });
}

class EcoCleaningScreen extends StatefulWidget {
  const EcoCleaningScreen({Key? key}) : super(key: key);

  @override
  State<EcoCleaningScreen> createState() => _EcoCleaningScreenState();
}

class _EcoCleaningScreenState extends State<EcoCleaningScreen> {
  final List<EcoOption> _options = [
    EcoOption(
      name: 'Eco Products',
      description: 'Use of environmentally friendly cleaning products',
      price: 500,
    ),
    EcoOption(
      name: 'Microfiber',
      description: 'Use of microfiber cloths instead of regular ones',
      price: 300,
    ),
    EcoOption(
      name: 'Steam Cleaning',
      description: 'Use of steam cleaner for disinfection',
      price: 1000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Cleaning'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eco-friendly cleaning options',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _options.length,
              itemBuilder: (context, index) {
                final option = _options[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Icon(
                      Icons.eco,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      option.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(option.description),
                    trailing: Switch(
                      value: option.isSelected,
                      onChanged: (value) {
                        setState(() {
                          option.isSelected = value;
                        });
                      },
                      activeColor: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            if (_options.where((o) => o.isSelected).isNotEmpty) ...[
              Text(
                'Selected options:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _options.where((o) => o.isSelected).length,
                itemBuilder: (context, index) {
                  final option = _options.where((o) => o.isSelected).toList()[index];
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.eco,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    title: Text(
                      option.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _options.where((o) => o.isSelected).isNotEmpty
                    ? () {
                        // TODO: Save selected options
                        Navigator.pop(context);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 