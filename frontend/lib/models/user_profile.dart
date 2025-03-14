import './cleaning_activity.dart';

class UserProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final List<String> addresses;
  final List<String> paymentMethods;
  final List<String> bookings;
  final double rating;
  final List<CleaningActivity> activities;
  final int points;

  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.addresses,
    required this.paymentMethods,
    required this.bookings,
    this.rating = 0.0,
    this.activities = const [],
    this.points = 0,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': phone,
    'addresses': addresses,
    'paymentMethods': paymentMethods,
    'bookings': bookings,
    'rating': rating,
    'activities': activities.map((a) => a.toJson()).toList(),
    'points': points,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    addresses: List<String>.from(json['addresses']),
    paymentMethods: List<String>.from(json['paymentMethods']),
    bookings: List<String>.from(json['bookings']),
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    activities: (json['activities'] as List<dynamic>?)
        ?.map((a) => CleaningActivity.fromJson(a as Map<String, dynamic>))
        .toList() ?? [],
    points: (json['points'] as int?) ?? 0,
  );
} 