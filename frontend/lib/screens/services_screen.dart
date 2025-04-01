import 'package:flutter/material.dart';
import '../utils/sample_data.dart';
import '../widgets/common/bottom_navbar.dart';
import '../widgets/cards/service_detail_card.dart';
import '../widgets/sheets/service_details_sheet.dart';
import '../utils/constants.dart';
import '../models/service.dart';
import '../screens/home_screen.dart';
import '../screens/activity_screen.dart';
import '../screens/user_profile_screen.dart';

class ServicesScreen extends StatefulWidget {
  final List<Service> services;
  final int selectedIndex;
  
  const ServicesScreen({
    super.key,
    required this.services,
    required this.selectedIndex,
  });

  @override
  ServicesScreenState createState() => ServicesScreenState();
}

class ServicesScreenState extends State<ServicesScreen> {
  late int _selectedIndex;
  int _selectedCategoryIndex = 0;
  
  final List<String> _categories = [
    'All',
    'Standard',
    'Deep Cleaning',
    'Move-in/Move-out',
    'Office',
    'Special',
  ];
  
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }
  
  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }
    
    if (index == 0) {
      // Navigate to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            services: widget.services,
            promotions: SampleData.promotions,
          ),
        ),
      );
    } else if (index == 2) {
      // Navigate to Activity
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ActivityScreen(),
        ),
      );
    } else if (index == 3) {
      // Navigate to Profile
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(profile: SampleData.userProfile),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  
  void _selectCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: _selectedCategoryIndex == _categories.indexOf(category),
                    label: Text(category),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategoryIndex = selected ? _categories.indexOf(category) : 0;
                      });
                    },
                    backgroundColor: AppColors.darkGrey,
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: _selectedCategoryIndex == _categories.indexOf(category)
                          ? AppColors.primary
                          : AppColors.white,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Services list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: widget.services.length,
              itemBuilder: (context, index) {
                final service = widget.services[index];
                return ServiceDetailCard(
                  title: service.title,
                  price: '\$${service.price.toStringAsFixed(2)}',
                  duration: '${service.duration} min',
                  description: service.description,
                  onTap: () => _showServiceDetails(service),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: widget.selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
} 