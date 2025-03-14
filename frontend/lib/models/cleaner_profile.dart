import './review.dart';
import './cleaning_activity.dart';

class CleanerProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final double rating;
  final int totalCleanings;
  final double earnings;
  final List<Review> reviews;
  final List<String> certificates;
  final List<String> paymentMethods;
  final List<String> activities;

  const CleanerProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.rating,
    required this.totalCleanings,
    required this.earnings,
    required this.reviews,
    required this.certificates,
    required this.paymentMethods,
    required this.activities,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': phone,
    'rating': rating,
    'totalCleanings': totalCleanings,
    'earnings': earnings,
    'reviews': reviews.map((r) => r.toJson()).toList(),
    'certificates': certificates,
    'paymentMethods': paymentMethods,
    'activities': activities,
  };

  factory CleanerProfile.fromJson(Map<String, dynamic> json) => CleanerProfile(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    rating: (json['rating'] as num).toDouble(),
    totalCleanings: json['totalCleanings'] as int,
    earnings: (json['earnings'] as num).toDouble(),
    reviews: (json['reviews'] as List<dynamic>)
        .map((r) => Review.fromJson(r as Map<String, dynamic>))
        .toList(),
    certificates: List<String>.from(json['certificates']),
    paymentMethods: List<String>.from(json['paymentMethods']),
    activities: List<String>.from(json['activities']),
  );
}

class CleaningMetric {
  final String category;
  final double percentage;

  const CleaningMetric({
    required this.category,
    required this.percentage,
  });

  Map<String, dynamic> toJson() => {
    'category': category,
    'percentage': percentage,
  };

  factory CleaningMetric.fromJson(Map<String, dynamic> json) => CleaningMetric(
    category: json['category'] as String,
    percentage: (json['percentage'] as num).toDouble(),
  );
} 