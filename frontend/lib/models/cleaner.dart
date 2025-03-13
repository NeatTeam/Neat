class Cleaner {
  final String id;
  final String name;
  final double rating;
  final int reviewCount;
  final String description;
  final String image;
  final bool available;

  Cleaner({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.image,
    this.available = true,
  });

  // Create from map for easy conversion from hard-coded data
  factory Cleaner.fromMap(Map<String, dynamic> map) {
    return Cleaner(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      rating: map['rating'] ?? 0.0,
      reviewCount: map['reviewCount'] ?? 0,
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      available: map['available'] ?? true,
    );
  }

  // Convert to map for future storage/API usage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'reviewCount': reviewCount,
      'description': description,
      'image': image,
      'available': available,
    };
  }

  // Add a toJson alias for compatibility
  Map<String, dynamic> toJson() => toMap();
} 