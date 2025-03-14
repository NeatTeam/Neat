import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/common/bottom_navbar.dart';

class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final bool isIncome;

  const Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      description: 'Оплата за уборку',
      amount: 3500,
      date: DateTime.now().subtract(const Duration(days: 1)),
      isIncome: true,
    ),
    Transaction(
      id: '2',
      description: 'Вывод средств',
      amount: 5000,
      date: DateTime.now().subtract(const Duration(days: 3)),
      isIncome: false,
    ),
    Transaction(
      id: '3',
      description: 'Оплата за уборку',
      amount: 2500,
      date: DateTime.now().subtract(const Duration(days: 5)),
      isIncome: true,
    ),
  ];

  double get _balance {
    return _transactions.fold(
      0,
      (sum, transaction) =>
          sum + (transaction.isIncome ? transaction.amount : -transaction.amount),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Кошелек',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildBalanceCard(),
          const SizedBox(height: 24),
          _buildTransactionsList(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Баланс',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_balance.toStringAsFixed(0)} ₽',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement withdrawal
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Вывести',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'История',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Show full history
                    },
                    child: const Text(
                      'Вся история',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _transactions.length,
                separatorBuilder: (context, index) => const Divider(
                  color: AppColors.divider,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: transaction.isIncome
                            ? AppColors.success.withOpacity(0.1)
                            : AppColors.error.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        transaction.isIncome
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: transaction.isIncome
                            ? AppColors.success
                            : AppColors.error,
                      ),
                    ),
                    title: Text(
                      transaction.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${transaction.date.day}.${transaction.date.month}.${transaction.date.year}',
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      '${transaction.isIncome ? '+' : '-'}${transaction.amount.toStringAsFixed(0)} ₽',
                      style: TextStyle(
                        color: transaction.isIncome
                            ? AppColors.success
                            : AppColors.error,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 