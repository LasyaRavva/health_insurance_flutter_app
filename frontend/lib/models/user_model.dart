class User {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String policyNumber;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.policyNumber,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      policyNumber: json['policyNumber'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'policyNumber': policyNumber,
      'profileImage': profileImage,
    };
  }
}
