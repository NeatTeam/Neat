import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PaymentMethod {
  final String id;
  final String type;
  final String lastFourDigits;
  final String expiryDate;
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    required this.expiryDate,
    this.isDefault = false,
  });
}

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: '1',
      type: 'visa',
      lastFourDigits: '4242',
      expiryDate: '12/24',
      isDefault: true,
    ),
    PaymentMethod(
      id: '2',
      type: 'mastercard',
      lastFourDigits: '8888',
      expiryDate: '06/25',
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
          'Способы оплаты',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _paymentMethods.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final method = _paymentMethods[index];
                return _buildPaymentMethodCard(method);
              },
            ),
          ),
          _buildAddButton(),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            'assets/images/${method.type}.png',
            width: 32,
            height: 32,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                method.type == 'visa' ? Icons.credit_card : Icons.credit_card,
                color: AppColors.primary,
                size: 32,
              );
            },
          ),
        ),
        title: Row(
          children: [
            Text(
              method.type.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '•••• ${method.lastFourDigits}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Text(
                'До ${method.expiryDate}',
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),
              if (method.isDefault) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Основная',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.secondaryText,
          ),
          color: AppColors.surface,
          itemBuilder: (context) => [
            if (!method.isDefault)
              const PopupMenuItem(
                value: 'make_default',
                child: Text(
                  'Сделать основной',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            const PopupMenuItem(
              value: 'delete',
              child: Text(
                'Удалить',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'make_default') {
              setState(() {
                for (var m in _paymentMethods) {
                  if (m.id == method.id) {
                    _paymentMethods[_paymentMethods.indexOf(m)] = PaymentMethod(
                      id: m.id,
                      type: m.type,
                      lastFourDigits: m.lastFourDigits,
                      expiryDate: m.expiryDate,
                      isDefault: true,
                    );
                  } else {
                    _paymentMethods[_paymentMethods.indexOf(m)] = PaymentMethod(
                      id: m.id,
                      type: m.type,
                      lastFourDigits: m.lastFourDigits,
                      expiryDate: m.expiryDate,
                      isDefault: false,
                    );
                  }
                }
              });
            } else if (value == 'delete') {
              _showDeleteDialog(method);
            }
          },
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Show add payment method dialog
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Добавить способ оплаты',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(PaymentMethod method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Удалить способ оплаты',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Вы уверены, что хотите удалить карту ${method.type.toUpperCase()} •••• ${method.lastFourDigits}?',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Отмена',
              style: TextStyle(
                color: AppColors.secondaryText,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _paymentMethods.removeWhere((m) => m.id == method.id);
              });
              Navigator.pop(context);
            },
            child: Text(
              'Удалить',
              style: TextStyle(
                color: Colors.red[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 