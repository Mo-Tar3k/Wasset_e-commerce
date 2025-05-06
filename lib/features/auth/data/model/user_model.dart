import 'package:e_commerce/features/auth/data/domain/entites/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uId,
    required super.email,
    required super.name,
    required super.role,
    required super.phoneNumber,
    super.profileImage,
    super.profession,
    super.bio,
  });

  factory UserModel.fromFirebaseUser(User user) {
    String role =
        user.providerData.isNotEmpty
            ? user.providerData[0].providerId
            : 'Customer';

    if (role == 'google.com' || role == 'facebook.com') {
      role = 'Customer';
    }

    return UserModel(
      uId: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      role: role,
      phoneNumber: user.phoneNumber ?? '',
      profileImage: null,
      profession: null,
      bio: null,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      phoneNumber: json['phoneNumber'] ?? '',
      profileImage: json['profileImage'], // يسمح بالقيمة null
      profession: json['profession'], // يسمح بالقيمة null
      bio: json['bio'], // يسمح بالقيمة null
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      uId: user.uId,
      email: user.email,
      name: user.name,
      role: user.role,
      phoneNumber: user.phoneNumber,
      profileImage: user.profileImage,
      profession: user.profession,
      bio: user.bio,
    );
  }

  Map<String, dynamic> toMap() => {
    'uId': uId,
    'email': email,
    'name': name,
    'role': role,
    'phoneNumber': phoneNumber,
    'profileImage': profileImage, // يخزن القيمة كما هي
    'profession': profession, // يخزن القيمة كما هي
    'bio': bio, // يخزن القيمة كما هي
  };
  @override
  UserModel copyWith({
    String? uId,
    String? email,
    String? name,
    String? role,
    String? phoneNumber,
    String? profileImage,
    String? profession,
    String? bio,
  }) {
    final updatedEntity = super.copyWith(
      uId: uId,
      email: email,
      name: name,
      role: role,
      phoneNumber: phoneNumber,
      profileImage: profileImage,
      profession: profession,
      bio: bio,
    );

    return UserModel.fromEntity(updatedEntity);
  }
}
