import 'package:flutter/material.dart';
import '../models/service.dart';
import '../models/cleaner.dart';
import '../models/promotion.dart';
import '../models/cleaner_profile.dart';
import '../models/user_profile.dart';
import '../models/review.dart';
import '../models/cleaning_activity.dart';

// Sample data class for storing test data
class SampleData {
  // Sample services
  static List<Service> services = [
    Service(
      title: 'Standard Cleaning',
      price: 49.99,
      duration: 120,
      image: 'assets/images/standard_cleaning.png',
      description: 'Our basic cleaning package includes dusting, vacuuming, and cleaning of all rooms.',
    ),
    Service(
      title: 'Deep Cleaning',
      price: 89.99,
      duration: 180,
      image: 'assets/images/deep_cleaning.png',
      description: 'A thorough cleaning of your entire home, including areas often missed in regular cleaning.',
    ),
    Service(
      title: 'Move-in/Move-out',
      price: 129.99,
      duration: 240,
      image: 'assets/images/move_cleaning.png',
      description: 'Prepare your new home or leave your old one spotless with our specialized cleaning service.',
    ),
    Service(
      title: 'Window Cleaning',
      price: 69.99,
      duration: 90,
      image: 'assets/images/window_cleaning.png',
      description: 'Crystal clear windows inside and out, including frames and sills.',
    ),
    Service(
      title: 'Carpet Cleaning',
      price: 79.99,
      duration: 120,
      image: 'assets/images/carpet_cleaning.png',
      description: 'Deep steam cleaning for carpets to remove stains, dirt, and allergens.',
    ),
  ];

  // Sample cleaners
  static List<Cleaner> cleaners = [
    Cleaner(
      id: 'c1',
      name: 'Sarah Johnson',
      rating: 4.9,
      reviewCount: 189,
      description: 'Professional cleaner with 5 years of experience',
      image: 'assets/images/cleaner1.png',
    ),
    Cleaner(
      id: 'c2',
      name: 'Michael Smith',
      rating: 4.8,
      reviewCount: 156,
      description: 'Specialized in deep cleaning and sanitization',
      image: 'assets/images/cleaner2.png',
    ),
    Cleaner(
      id: 'c3',
      name: 'Emily Davis',
      rating: 4.7,
      reviewCount: 132,
      description: 'Eco-friendly cleaning expert',
      image: 'assets/images/cleaner3.png',
    ),
  ];

  // Sample promotions
  static List<Promotion> promotions = [
    Promotion(
      title: '20% off your first cleaning',
      code: 'NEAT20',
      validUntil: 'Valid until Aug 31',
      color: 0xFF8A2BE2, // Deep purple
    ),
    Promotion(
      title: 'Free window cleaning with any deep clean',
      code: 'WINDOWS',
      validUntil: 'Valid until Sep 15',
      color: 0xFF1E88E5, // Blue
    ),
    Promotion(
      title: 'Refer a friend and get \$25 off',
      code: 'REFER25',
      validUntil: 'No expiration',
      color: 0xFF43A047, // Green
    ),
  ];

  // Sample cleaner profile
  static final cleanerProfile = CleanerProfile(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    phone: '+1 234 567 8900',
    rating: 4.8,
    totalCleanings: 156,
    earnings: 4500.0,
    reviews: [
      Review(
        id: '1',
        authorName: 'Alice Brown',
        rating: 5.0,
        text: 'Great service!',
        date: DateTime(2024, 3, 15),
      ),
      Review(
        id: '2',
        authorName: 'Bob Wilson',
        rating: 4.8,
        text: 'Very professional',
        date: DateTime(2024, 3, 10),
      ),
      Review(
        id: '3',
        authorName: 'Carol Davis',
        rating: 4.7,
        text: 'Would recommend',
        date: DateTime(2024, 3, 5),
      ),
    ],
    certificates: [
      'Professional Cleaning Certificate',
      'Health & Safety Training',
    ],
    paymentMethods: [
      'Credit Card',
      'PayPal',
    ],
    activities: [
      'Deep Cleaning',
      'Regular Maintenance',
      'Window Cleaning',
    ],
  );

  // Sample user profile
  static final userProfile = UserProfile(
    firstName: 'Jane',
    lastName: 'Smith',
    email: 'jane.smith@example.com',
    phone: '+1 234 567 8901',
    addresses: [
      '123 Main St, Apt 4B, New York, NY 10001',
      '456 Park Ave, Suite 7, New York, NY 10002',
    ],
    paymentMethods: [
      'Credit Card',
      'PayPal',
    ],
    bookings: [
      'Booking #1234',
      'Booking #1235',
    ],
    rating: 4.8,
    activities: [
      CleaningActivity(
        id: 'ca1',
        type: 'Deep Cleaning',
        date: DateTime(2024, 3, 15),
        price: 89.99,
        address: '123 Main St, Apt 4B, New York, NY 10001',
        cleanerName: 'Sarah Johnson',
        status: 'Completed',
      ),
      CleaningActivity(
        id: 'ca2',
        type: 'Standard Cleaning',
        date: DateTime(2024, 3, 1),
        price: 49.99,
        address: '123 Main St, Apt 4B, New York, NY 10001',
        cleanerName: 'Michael Smith',
        status: 'Scheduled',
      ),
    ],
    points: 2400,
  );
} 