class Clinic {
  String name;
  String distance;
  double? rating;

  Clinic({
    required this.name,
    required this.distance,
    this.rating,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      name: json['name'] ?? '',
      distance: json['distance'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'distance': distance,
      'rating': rating,
    };
  }
}