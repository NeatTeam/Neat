class CleaningActivity {
  final String id;
  final String type;
  final DateTime date;
  final double price;
  final String address;
  final String cleanerName;
  final String status;

  const CleaningActivity({
    required this.id,
    required this.type,
    required this.date,
    required this.price,
    required this.address,
    required this.cleanerName,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'date': date.toIso8601String(),
    'price': price,
    'address': address,
    'cleanerName': cleanerName,
    'status': status,
  };

  factory CleaningActivity.fromJson(Map<String, dynamic> json) => CleaningActivity(
    id: json['id'] as String,
    type: json['type'] as String,
    date: DateTime.parse(json['date'] as String),
    price: (json['price'] as num).toDouble(),
    address: json['address'] as String,
    cleanerName: json['cleanerName'] as String,
    status: json['status'] as String,
  );
} 