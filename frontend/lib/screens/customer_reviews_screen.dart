import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomerReview {
  final String id;
  final String cleanerName;
  final String cleanerAvatar;
  final double rating;
  final String text;
  final DateTime date;
  final String address;

  const CustomerReview({
    required this.id,
    required this.cleanerName,
    required this.cleanerAvatar,
    required this.rating,
    required this.text,
    required this.date,
    required this.address,
  });
}

class CustomerReviewsScreen extends StatelessWidget {
  const CustomerReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data
    final reviews = [
      CustomerReview(
        id: '1',
        cleanerName: 'Анна П.',
        cleanerAvatar: 'АП',
        rating: 5.0,
        text: 'Отличная уборка! Все чисто и аккуратно.',
        date: DateTime.now().subtract(const Duration(days: 2)),
        address: 'ул. Ленина, 1',
      ),
      CustomerReview(
        id: '2',
        cleanerName: 'Мария С.',
        cleanerAvatar: 'МС',
        rating: 4.5,
        text: 'Хорошая уборка, но можно было лучше протереть окна.',
        date: DateTime.now().subtract(const Duration(days: 7)),
        address: 'пр. Мира, 15',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Мои отзывы',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return _buildReviewCard(review);
        },
      ),
    );
  }

  Widget _buildReviewCard(CustomerReview review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    review.cleanerAvatar,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.cleanerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      review.address,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _formatDate(review.date),
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                );
              }),
              const SizedBox(width: 8),
              Text(
                review.rating.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (review.text.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              review.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} г. назад';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} мес. назад';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} д. назад';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ч. назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} мин. назад';
    } else {
      return 'Только что';
    }
  }
} 