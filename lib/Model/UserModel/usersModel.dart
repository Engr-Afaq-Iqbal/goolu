import 'dart:convert';

class UserModel {
  final String username;
  final String userId;
  final String dob;
  final String email;
  final String phoneNumber;
  final String iqamaNumber;
  final String profilePicture;
  final String country;
  final String gender;
  final String address;

  UserModel({
    required this.username,
    required this.userId,
    required this.dob,
    required this.email,
    required this.phoneNumber,
    required this.iqamaNumber,
    required this.profilePicture,
    required this.country,
    required this.gender,
    required this.address,
  });

  // Convert UserModel to Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userId': userId,
      'dob': dob,
      'email': email,
      'iqamaNumber': iqamaNumber,
      'phoneNumber': phoneNumber,
      'profilePic': profilePicture,
      'country': country,
      'gender': gender,
      'address': address,
    };
  }

  // Create UserModel from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      userId: map['userId'] ?? '',
      dob: map['dob'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      iqamaNumber: map['iqamaNumber'] ?? '',
      profilePicture: map['profilePic'] ?? '',
      country: map['country'] ?? 'USA',
      gender: map['gender'] ?? 'Male',
      address: map['address'] ?? '',
    );
  }
  // Convert UserModel to JSON String for local storage
  String toJson() => json.encode(toMap());

  // Create UserModel from JSON String
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
