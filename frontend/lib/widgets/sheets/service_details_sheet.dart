import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/service.dart';

class ServiceDetailsSheet extends StatelessWidget {
  final Service service;

  const ServiceDetailsSheet({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate a safe height for the bottom sheet based on screen size
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    // In landscape mode, use more of the screen
    final double bottomSheetHeight = isLandscape ? screenHeight * 0.9 : screenHeight * 0.8;
    
    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with close button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade800,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    service.title,
                    style: AppTextStyles.headline1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Service details
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service image placeholder - Use AspectRatio for consistent sizing
                  isLandscape 
                    ? _buildLandscapeLayout(context) 
                    : _buildPortraitLayout(context),
                  
                  const SizedBox(height: 24),
                  
                  // What's included section
                  const Text(
                    'What\'s Included',
                    style: AppTextStyles.headline3,
                  ),
                  const SizedBox(height: 16),
                  _buildIncludedItem(context, 'Dusting all accessible surfaces'),
                  _buildIncludedItem(context, 'Vacuuming floors and carpets'),
                  _buildIncludedItem(context, 'Mopping all floors'),
                  _buildIncludedItem(context, 'Cleaning bathrooms (toilets, showers, sinks)'),
                  _buildIncludedItem(context, 'Kitchen cleaning (countertops, appliances)'),
                  _buildIncludedItem(context, 'Emptying trash bins'),
                  const SizedBox(height: 24),
                  
                  // Reviews section (placeholder)
                  const Text(
                    'Reviews',
                    style: AppTextStyles.headline3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              for (int i = 0; i < 5; i++)
                                Icon(
                                  i < 5 ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Based on 120 reviews',
                            style: AppTextStyles.body2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Add padding at the bottom to ensure content isn't hidden by the button
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          
          // Bottom button
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Show booking flow - We'll need to modify this to access the order sheet
                  // For now, just close the sheet and show a snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Booking flow will be shown here'),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Book This Service',
                  style: AppTextStyles.button,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Layout for portrait mode
  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Service image placeholder
        AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.cleaning_services,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Price and duration
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      '\$${service.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Fixed Price',
                      style: AppTextStyles.body2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      '${service.duration} min',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Duration',
                      style: AppTextStyles.body2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Description
        const Text(
          'Description',
          style: AppTextStyles.headline3,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            service.description,
            style: AppTextStyles.body1,
            overflow: TextOverflow.ellipsis, 
            maxLines: 8,
          ),
        ),
        const SizedBox(height: 16),
        
        // More detailed description
        const Text(
          'Our professional cleaning team will handle all aspects of cleaning your space. This service includes dusting, vacuuming, mopping, bathroom cleaning, and kitchen cleaning. We use eco-friendly products and ensure a thorough job every time.',
          style: AppTextStyles.body2,
        ),
      ],
    );
  }
  
  // Layout for landscape mode
  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side: image
        Expanded(
          flex: 1,
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.cleaning_services,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        
        // Right side: details
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Price and duration
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '\$${service.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            'Fixed Price',
                            style: AppTextStyles.body2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${service.duration} min',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            'Duration',
                            style: AppTextStyles.body2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Description
              const Text(
                'Description',
                style: AppTextStyles.headline3,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  service.description,
                  style: AppTextStyles.body1,
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 8,
                ),
              ),
              const SizedBox(height: 12),
              
              // More detailed description
              const Text(
                'Our professional cleaning team will handle all aspects of cleaning your space.',
                style: AppTextStyles.body2,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildIncludedItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body1,
            ),
          ),
        ],
      ),
    );
  }
} 