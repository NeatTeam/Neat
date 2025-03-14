import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SettingsSection extends StatelessWidget {
  final String? title;
  final List<SettingsItem> items;

  const SettingsSection({
    Key? key,
    this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                title!,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          ...List.generate(
            items.length * 2 - 1,
            (index) {
              if (index.isOdd) {
                return const Divider(
                  color: AppColors.divider,
                  height: 1,
                  thickness: 1,
                );
              }
              final itemIndex = index ~/ 2;
              return _buildSettingsItem(items[itemIndex]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(SettingsItem item) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: item.color?.withOpacity(0.1) ?? AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          item.icon,
          color: item.color ?? AppColors.primary,
          size: 24,
        ),
      ),
      title: Text(
        item.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: item.subtitle != null
        ? Text(
            item.subtitle!,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
            ),
          )
        : null,
      trailing: item.trailing ??
        const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.primary,
          size: 16,
        ),
      onTap: item.onTap,
    );
  }
}

class SettingsItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? color;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.color,
    this.trailing,
    this.onTap,
  });
} 