class UserProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String birthDate;
  final String image;
  final String bloodGroup;
  final String companyTitle;
  final String companyName;
  final String city;
  final String state;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.companyTitle,
    required this.companyName,
    required this.city,
    required this.state,
  });

  String get fullName => '$firstName $lastName';

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final company = json['company'] as Map<String, dynamic>? ?? {};
    final address = json['address'] as Map<String, dynamic>? ?? {};

    return UserProfile(
      id: json['id'] as int? ?? 0,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      maidenName: json['maidenName'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      gender: json['gender'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      username: json['username'] as String? ?? '',
      birthDate: json['birthDate'] as String? ?? '',
      image: json['image'] as String? ?? '',
      bloodGroup: json['bloodGroup'] as String? ?? 'N/A',
      companyTitle: company['title'] as String? ?? 'Member',
      companyName: company['name'] as String? ?? 'Independent',
      city: address['city'] as String? ?? '',
      state: address['state'] as String? ?? '',
    );
  }
}
