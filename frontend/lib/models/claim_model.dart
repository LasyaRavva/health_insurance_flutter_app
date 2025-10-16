class Claim {
  final String id;
  final String userId;
  final String description;
  final String? imageUrl;
  final String status; // pending, approved, rejected
  final DateTime submittedAt;

  Claim({
    required this.id,
    required this.userId,
    required this.description,
    this.imageUrl,
    required this.status,
    required this.submittedAt,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      id: json['id'],
      userId: json['userId'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      status: json['status'],
      submittedAt: DateTime.parse(json['submittedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'description': description,
      'imageUrl': imageUrl,
      'status': status,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }
}
