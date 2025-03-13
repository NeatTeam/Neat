import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class PromotionCard extends StatelessWidget {
  final String title;
  final String code;
  final String validUntil;
  final int color;

  const PromotionCard({
    super.key,
    required this.title,
    required this.code,
    required this.validUntil,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(color).withOpacity(0.7),
            Color(color).withOpacity(0.4),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background decoration
          Positioned(
            bottom: -20,
            right: -20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Color(color).withOpacity(0.2),
            ),
          ),
          Positioned(
            top: -30,
            left: -30,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Color(color).withOpacity(0.1),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Left section (promo text)
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          code,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(color),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        validUntil,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Right section (icon)
                if (screenWidth > 320) // Only show the icon on screens wider than 320px
                  Flexible(
                    flex: 1, 
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: Color(color),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 