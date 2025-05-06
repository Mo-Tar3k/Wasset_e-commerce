class UserEntity {
  final String uId;
  final String email;
  final String name;
  final String role;
  final String phoneNumber;
  final String? profileImage;
  final String? profession;
  final String? bio;

  UserEntity({
    required this.uId,
    required this.email,
    required this.name,
    required this.role,
    required this.phoneNumber,
    this.profileImage,
    this.profession,
    this.bio,
  });

  UserEntity copyWith({
    String? uId,
    String? email,
    String? name,
    String? role,
    String? phoneNumber,
    String? profileImage,
    String? profession,
    String? bio,
  }) {
    return UserEntity(
      uId: uId ?? this.uId,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      profession: profession ?? this.profession,
      bio: bio ?? this.bio,
    );
  }
}
