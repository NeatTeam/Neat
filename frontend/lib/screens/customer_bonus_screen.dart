import 'package:flutter/material.dart';
import '../utils/constants.dart';

class BonusEarningOption {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  BonusEarningOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class BonusSpendingOption {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  BonusSpendingOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class CustomerBonusScreen extends StatefulWidget {
  const CustomerBonusScreen({Key? key}) : super(key: key);

  @override
  State<CustomerBonusScreen> createState() => _CustomerBonusScreenState();
}

class _CustomerBonusScreenState extends State<CustomerBonusScreen> {
  final List<BonusEarningOption> _earningOptions = [
    BonusEarningOption(
      icon: Icons.cleaning_services,
      title: 'Book Cleanings',
      description: 'Earn 5% cashback from each cleaning',
      color: Colors.blue,
    ),
    BonusEarningOption(
      icon: Icons.rate_review,
      title: 'Leave Reviews',
      description: 'Get 100 points for each review',
      color: Colors.green,
    ),
    BonusEarningOption(
      icon: Icons.people,
      title: 'Invite Friends',
      description: 'Get 500 points for each referral',
      color: Colors.orange,
    ),
  ];

  final List<BonusSpendingOption> _spendingOptions = [
    BonusSpendingOption(
      icon: Icons.local_offer,
      title: 'Cleaning Discount',
      description: 'Use points to get up to 20% off',
      color: Colors.purple,
    ),
    BonusSpendingOption(
      icon: Icons.add_circle,
      title: 'Additional Services',
      description: 'Get extra services for your points',
      color: Colors.teal,
    ),
    BonusSpendingOption(
      icon: Icons.card_giftcard,
      title: 'Gift Certificates',
      description: 'Exchange points for gift cards',
      color: Colors.pink,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Bonus Program',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBonusCard(),
            const SizedBox(height: 24),
            _buildHowToEarn(),
            const SizedBox(height: 24),
            _buildHowToSpend(),
          ],
        ),
      ),
    );
  }

  Widget _buildBonusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Balance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.savings,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '1,250',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'points',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.secondaryText,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '1 point = 1 ruble',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHowToEarn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ways to Earn',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _earningOptions.length,
          itemBuilder: (context, index) {
            final option = _earningOptions[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: Icon(
                  option.icon,
                  color: option.color,
                ),
                title: Text(
                  option.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(option.description),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to earning option details
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHowToSpend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ways to Spend',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _spendingOptions.length,
          itemBuilder: (context, index) {
            final option = _spendingOptions[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: Icon(
                  option.icon,
                  color: option.color,
                ),
                title: Text(
                  option.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(option.description),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to spending option details
                },
              ),
            );
          },
        ),
      ],
    );
  }
} 