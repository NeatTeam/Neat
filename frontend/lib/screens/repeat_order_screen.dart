import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PreviousOrder {
  final String id;
  final DateTime date;
  final String location;
  final String description;
  final int price;
  final String cleanerName;
  final double rating;

  PreviousOrder({
    required this.id,
    required this.date,
    required this.location,
    required this.description,
    required this.price,
    required this.cleanerName,
    required this.rating,
  });
}

class RepeatOrderScreen extends StatefulWidget {
  const RepeatOrderScreen({Key? key}) : super(key: key);

  @override
  State<RepeatOrderScreen> createState() => _RepeatOrderScreenState();
}

class _RepeatOrderScreenState extends State<RepeatOrderScreen> {
  final List<PreviousOrder> _orders = [
    PreviousOrder(
      id: '1',
      date: DateTime.now().subtract(const Duration(days: 7)),
      location: 'Kitchen',
      description: 'General kitchen cleaning',
      price: 2500,
      cleanerName: 'Anna',
      rating: 4.8,
    ),
    PreviousOrder(
      id: '2',
      date: DateTime.now().subtract(const Duration(days: 14)),
      location: 'Bathroom',
      description: 'Bathroom cleaning',
      price: 1800,
      cleanerName: 'Maria',
      rating: 4.9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repeat Order'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order.location,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${order.price} ₽',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(order.description),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 16,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            order.cleanerName,
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            order.rating.toString(),
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${order.date.day}.${order.date.month}.${order.date.year}',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Repeat Order'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement repeat order logic
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 