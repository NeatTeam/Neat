import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String price;
  final String duration;
  final String description;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.price,
    required this.duration,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with icon
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.cleaning_services,
                  color: AppColors.primary,
                  size: 36,
                ),
              ),
            ),
            // Bottom section with text
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: AppTextStyles.price,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$duration min',
                    style: AppTextStyles.body2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.body2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 