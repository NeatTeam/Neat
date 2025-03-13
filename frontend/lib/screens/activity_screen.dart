import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/common/bottom_navbar.dart';
import '../utils/sample_data.dart';
import 'home_screen.dart';
import 'services_screen.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Activity', style: AppTextStyles.headline2),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Upcoming cleanings section
          const Text('Upcoming', style: AppTextStyles.headline3),
          const SizedBox(height: 16),
          _buildUpcomingCleaning(
            context,
            date: DateTime.now().add(const Duration(days: 2)),
            time: '10:00 AM',
            service: 'Deep Cleaning',
            cleaner: 'Sarah Johnson',
            address: '123 Main St, Apt 4B',
            price: 129.99,
          ),
          const SizedBox(height: 12),
          _buildUpcomingCleaning(
            context,
            date: DateTime.now().add(const Duration(days: 7)),
            time: '2:00 PM',
            service: 'Regular Cleaning',
            cleaner: 'Mike Smith',
            address: '456 Park Ave, Suite 2C',
            price: 89.99,
          ),

          const SizedBox(height: 32),

          // Past cleanings section
          const Text('Past', style: AppTextStyles.headline3),
          const SizedBox(height: 16),
          _buildPastCleaning(
            context,
            date: DateTime.now().subtract(const Duration(days: 5)),
            service: 'Deep Cleaning',
            cleaner: 'Sarah Johnson',
            rating: 5,
            price: 129.99,
          ),
          const SizedBox(height: 12),
          _buildPastCleaning(
            context,
            date: DateTime.now().subtract(const Duration(days: 12)),
            service: 'Regular Cleaning',
            cleaner: 'Mike Smith',
            rating: 4,
            price: 89.99,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,  // Set to 2 for activity tab
        onTap: (index) {
          if (index == 0) {
            // Navigate to Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  services: SampleData.services,
                  promotions: SampleData.promotions,
                ),
              ),
            );
          } else if (index == 1) {
            // Navigate to Services
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ServicesScreen(
                  services: SampleData.services,
                  selectedIndex: index,
                ),
              ),
            );
          }
          // Don't need to handle index 2 as we're already on Activity
          // Add index 3 (Profile) handling when that screen is created
        },
      ),
    );
  }

  Widget _buildUpcomingCleaning(
    BuildContext context, {
    required DateTime date,
    required String time,
    required String service,
    required String cleaner,
    required String address,
    required double price,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service and price header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(service, style: AppTextStyles.subtitle1),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: AppTextStyles.price,
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and time
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${date.day}/${date.month}/${date.year}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            time,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Cleaner
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(cleaner, style: AppTextStyles.body1),
                  ],
                ),
                const SizedBox(height: 12),

                // Address
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        address,
                        style: AppTextStyles.body2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle reschedule
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Reschedule'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle cancel
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastCleaning(
    BuildContext context, {
    required DateTime date,
    required String service,
    required String cleaner,
    required int rating,
    required double price,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service and price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(service, style: AppTextStyles.subtitle1),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: AppTextStyles.price,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Date and rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${date.day}/${date.month}/${date.year}',
                style: AppTextStyles.body2,
              ),
              Row(
                children: [
                  ...List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Cleaner
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(cleaner, style: AppTextStyles.body1),
            ],
          ),
          const SizedBox(height: 12),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle booking again
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Book Again'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle leaving a review
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Leave Review'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 