import 'package:flutter/material.dart';
import '../widgets/common/bottom_navbar.dart';
import '../widgets/cards/service_card.dart';
import '../widgets/cards/promotion_card.dart';
import '../widgets/sheets/order_sheet.dart';
import '../screens/services_screen.dart';
import '../screens/activity_screen.dart';
import '../utils/constants.dart';
import '../models/service.dart';
import '../models/promotion.dart';
import '../widgets/sheets/service_details_sheet.dart';

class HomeScreen extends StatefulWidget {
  final List<Service> services;
  final List<Promotion> promotions;
  
  const HomeScreen({
    Key? key,
    required this.services,
    required this.promotions,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _address = AppConstants.defaultAddress;

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigate to Services screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServicesScreen(
            services: widget.services,
            selectedIndex: index,
          ),
        ),
      );
    } else if (index == 2) {
      // Navigate to Activity screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ActivityScreen(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showOrderSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return OrderSheet(address: _address);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layouts
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar with user greeting
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good Morning,',
                          style: AppTextStyles.body2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Alex',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Address section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Home address button
                      InkWell(
                        onTap: () {
                          // This would open an address selector in a real app
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Address selector would open here'),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey.shade700,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.home,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'HOME',
                                      style: AppTextStyles.caption,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _address,
                                      style: AppTextStyles.body1,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // This would open an address selector in a real app
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Address selector would open here'),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                ),
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // "Order Cleaning Now" button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _showOrderSheet,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Order Cleaning Now',
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Popular services section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Services',
                      style: AppTextStyles.sectionTitle,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServicesScreen(
                              services: widget.services,
                              selectedIndex: 1,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: widget.services.length,
                  itemBuilder: (context, index) {
                    final service = widget.services[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ServiceCard(
                        title: service.title,
                        price: '\$${service.price}',
                        duration: '${service.duration}',
                        description: service.description,
                        onTap: () {
                          // Show service details bottom sheet using the ServiceDetailsSheet
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return ServiceDetailsSheet(service: service);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Promotions section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Special Offers',
                  style: AppTextStyles.sectionTitle,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: widget.promotions.length,
                  itemBuilder: (context, index) {
                    final promotion = widget.promotions[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: PromotionCard(
                        title: promotion.title,
                        code: promotion.code,
                        validUntil: promotion.validUntil,
                        color: promotion.color,
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
  
  Widget _buildEmptyBookings() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 48,
            color: AppColors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No recent bookings',
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 8),
          Text(
            'Your cleaning history will appear here',
            style: AppTextStyles.body2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServicesScreen(
                    services: widget.services,
                    selectedIndex: 1,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Book a Service'),
          ),
        ],
      ),
    );
  }
} 