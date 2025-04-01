import 'package:flutter/material.dart';
import '../utils/sample_data.dart';
import '../widgets/common/bottom_navbar.dart';
import '../utils/constants.dart';
import '../models/service.dart';
import '../screens/cleaner_profile_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/activity_screen.dart';
import '../widgets/sheets/service_details_sheet.dart';
import '../screens/add_service_screen.dart';

class CleanerServicesScreen extends StatefulWidget {
  const CleanerServicesScreen({super.key});

  @override
  State<CleanerServicesScreen> createState() => _CleanerServicesScreenState();
}

class _CleanerServicesScreenState extends State<CleanerServicesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Service> _filteredServices = [];
  List<Service> _myServices = [];

  @override
  void initState() {
    super.initState();
    _myServices = SampleData.services;
    _filteredServices = _myServices;
  }

  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredServices = _myServices;
      } else {
        _filteredServices = _myServices
            .where((service) =>
                service.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showServiceDetails(Service service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ServiceDetailsSheet(service: service);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Services'),
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddServiceScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterServices,
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.darkGrey,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              style: const TextStyle(color: AppColors.white),
            ),
          ),
          
          // Services grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredServices.length + 1, // +1 for add button
              itemBuilder: (context, index) {
                if (index == _filteredServices.length) {
                  // Add new service button
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddServiceScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  );
                }

                final service = _filteredServices[index];
                return InkWell(
                  onTap: () => _showServiceDetails(service),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cleaning_services,
                          size: 40,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          service.title,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${service.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CleanerProfileScreen(profile: SampleData.cleanerProfile),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatScreen(isCleaner: true),
              ),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CleanerProfileScreen(profile: SampleData.cleanerProfile),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 