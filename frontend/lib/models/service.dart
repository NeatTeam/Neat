import 'package:flutter/material.dart';

class Service {
  final String title;
  final double price;
  final int duration;
  final String image;
  final String description;
  final double rating;
  final int reviewCount;

  Service({
    required this.title,
    required this.price,
    required this.duration,
    required this.image,
    required this.description,
    this.rating = 4.8,
    this.reviewCount = 120,
  });

  // Create from map for easy conversion from hard-coded data
  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      title: map['title'] ?? '',
      price: (map['price'] is num) ? (map['price'] as num).toDouble() : 0.0,
      duration: map['duration'] ?? 0,
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      rating: (map['rating'] is num) ? (map['rating'] as num).toDouble() : 4.8,
      reviewCount: map['reviewCount'] ?? 120,
    );
  }

  // Convert to map for future storage/API usage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'duration': duration,
      'image': image,
      'description': description,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }

  // Add a toJson alias for compatibility
  Map<String, dynamic> toJson() => toMap();
} 