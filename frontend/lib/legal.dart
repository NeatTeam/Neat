import 'package:flutter/material.dart';

// Re-export the color scheme since it's used in this file
class AppColors {
  static const Color platinum = Color(0xFFE4E2E2);
  static const Color darkSpringGreen = Color(0xFF3B6F3F);
  static const Color raisinBlack = Color(0xFF292828);
  static const Color davyGray = Color(0xFF4A4A4A);
  static const Color cadetGray = Color(0xFF9E9E9E);
}

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Legal Information',
          style: TextStyle(color: AppColors.platinum),
        ),
        backgroundColor: AppColors.darkSpringGreen,
        iconTheme: const IconThemeData(color: AppColors.platinum),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.platinum,
              AppColors.platinum.withOpacity(0.8),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkSpringGreen,
                ),
              ),
              const SizedBox(height: 20),
              _buildSection(
                'Service Agreement',
                'By booking our cleaning services, you agree to these terms and conditions. Our cleaning professionals will perform the services as described in the service description with reasonable care and skill.',
              ),
              _buildSection(
                'Liability',
                'We maintain comprehensive insurance coverage for our cleaning services. However, we are not liable for any pre-existing damage or wear and tear to your property. Please report any concerns within 24 hours of service completion.',
              ),
              _buildSection(
                'Cancellation Policy',
                'We require 24 hours notice for cancellations. Late cancellations may be subject to a cancellation fee of up to 50% of the service cost.',
              ),
              _buildSection(
                'Privacy Policy',
                'We respect your privacy and handle all personal information in accordance with applicable data protection laws. Your information will only be used to provide and improve our services.',
              ),
              _buildSection(
                'Service Guarantee',
                'We strive for 100% customer satisfaction. If you are not satisfied with our service, please contact us within 24 hours and we will rectify any issues at no additional cost.',
              ),
              _buildSection(
                'Payment Terms',
                'Payment is due upon completion of services. We accept major credit cards, digital payments, and bank transfers. Regular cleaning services may be billed on a recurring basis as agreed.',
              ),
              _buildSection(
                'Property Access',
                'You must provide safe and reasonable access to your property at the scheduled time. Please secure any valuable items and inform us of any special instructions or areas to avoid.',
              ),
              _buildSection(
                'Equipment and Supplies',
                'We provide our own professional-grade cleaning equipment and supplies. If you prefer specific products to be used, please discuss this with us beforehand.',
              ),
              const SizedBox(height: 20),
              Text(
                'Last Updated: March 2024',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppColors.davyGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.platinum,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.davyGray.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkSpringGreen,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: AppColors.raisinBlack,
            ),
          ),
        ],
      ),
    );
  }
}
