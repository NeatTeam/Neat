class Review {
  final String id;
  final String authorName;
  final double rating;
  final String text;
  final DateTime date;
  final String? authorAvatar;

  const Review({
    required this.id,
    required this.authorName,
    required this.rating,
    required this.text,
    required this.date,
    this.authorAvatar,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'authorName': authorName,
    'rating': rating,
    'text': text,
    'date': date.toIso8601String(),
    'authorAvatar': authorAvatar,
  };

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json['id'] as String,
    authorName: json['authorName'] as String,
    rating: json['rating'] as double,
    text: json['text'] as String,
    date: DateTime.parse(json['date'] as String),
    authorAvatar: json['authorAvatar'] as String?,
  );
} 