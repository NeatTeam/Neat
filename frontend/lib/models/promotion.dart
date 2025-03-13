import 'package:flutter/material.dart';

class Promotion {
  final String title;
  final String code;
  final String validUntil;
  final int color;

  Promotion({
    required this.title,
    required this.code,
    required this.validUntil,
    required this.color,
  });

  // Create from map for easy conversion from hard-coded data
  factory Promotion.fromMap(Map<String, dynamic> map) {
    return Promotion(
      title: map['title'] ?? '',
      code: map['code'] ?? '',
      validUntil: map['validUntil'] ?? '',
      color: map['color'] ?? Colors.green.value,
    );
  }

  // Convert to map for future storage/API usage (note: color requires special handling)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'code': code,
      'validUntil': validUntil,
      'color': color,
    };
  }

  // Add a toJson alias for compatibility
  Map<String, dynamic> toJson() => toMap();
} 