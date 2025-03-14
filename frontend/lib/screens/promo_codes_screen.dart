import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PromoCode {
  final String code;
  final String description;
  final double discount;
  final DateTime expiryDate;
  final bool isActive;

  PromoCode({
    required this.code,
    required this.description,
    required this.discount,
    required this.expiryDate,
    this.isActive = true,
  });
}

class PromoCodesScreen extends StatefulWidget {
  const PromoCodesScreen({Key? key}) : super(key: key);

  @override
  State<PromoCodesScreen> createState() => _PromoCodesScreenState();
}

class _PromoCodesScreenState extends State<PromoCodesScreen> {
  final TextEditingController _codeController = TextEditingController();

  final List<PromoCode> _promoCodes = [
    PromoCode(
      code: 'WELCOME20',
      description: '20% off your first cleaning',
      discount: 20,
      expiryDate: DateTime.now().add(const Duration(days: 30)),
    ),
    PromoCode(
      code: 'SUMMER15',
      description: '15% off summer cleaning',
      discount: 15,
      expiryDate: DateTime.now().add(const Duration(days: 60)),
    ),
  ];

  void _showAddPromoCodeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Promo Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Enter promo code',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Handle promo code validation
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo Codes'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _promoCodes.length,
        itemBuilder: (context, index) {
          final promo = _promoCodes[index];
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
              children: [
                ListTile(
                  title: Text(
                    promo.code,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(promo.description),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${promo.discount}%',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.secondaryText,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Valid until ${promo.expiryDate.day}.${promo.expiryDate.month}.${promo.expiryDate.year}',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPromoCodeDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
} 