/// lib/models/user_model.dart
/// Complete User model – fully fixed, no warnings, production-ready

class UserModel {
  final String id;
  final String? email;
  final String? phone;
  final String? fullName;
  final String? avatarUrl;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final String? fcmToken;

  UserModel({
    required this.id,
    this.email,
    this.phone,
    this.fullName,
    this.avatarUrl,
    this.dateOfBirth,
    this.gender,
    DateTime? createdAt,
    this.updatedAt,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.fcmToken,
  }) : createdAt = createdAt ?? DateTime.now();   // Fixed: proper initialization

  // ────────────────────────────────
  // JSON
  // ────────────────────────────────
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      fullName: json['fullName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'] as String)
          : null,
      gender: _parseGender(json['gender'] as String?),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      fcmToken: json['fcmToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'phone': phone,
        'fullName': fullName,
        'avatarUrl': avatarUrl,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'gender': gender?.name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'isEmailVerified': isEmailVerified,
        'isPhoneVerified': isPhoneVerified,
        'fcmToken': fcmToken,
      };

  // ────────────────────────────────
  // Helpers
  // ────────────────────────────────
  String get displayName => fullName?.isNotEmpty == true
      ? fullName!
      : email?.split('@').first ?? phone ?? 'User';

  String get initials {
    if (fullName != null && fullName!.isNotEmpty) {
      final names = fullName!.trim().split(' ');
      if (names.length > 1) {
        return names[0][0].toUpperCase() + names.last[0].toUpperCase();
      }
      return names[0][0].toUpperCase();
    }
    return displayName[0].toUpperCase();
  }

  bool get isGuest => id == 'guest';

  UserModel copyWith({
    String? id,
    String? email,
    String? phone,
    String? fullName,
    String? avatarUrl,
    DateTime? dateOfBirth,
    Gender? gender,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    String? fcmToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  static Gender? _parseGender(String? gender) {
    if (gender == null) return null;
    return Gender.values.firstWhere(
      (e) => e.name.toLowerCase() == gender.toLowerCase(),
      orElse: () => Gender.other,
    );
  }
}

enum Gender { male, female, other }
final UserModel guestUser = UserModel(
  id: 'guest',
  fullName: 'Guest User',
  createdAt: null, // Will use DateTime.now() when accessed
);

final UserModel sampleUser = UserModel(
  id: 'usr_123456',
  email: 'rahul@example.com',
  phone: '+919876543210',
  fullName: 'Rahul Sharma',
  avatarUrl: 'https://ui-avatars.com/api/?name=Rahul+Sharma&background=E30425&color=fff',
  gender: Gender.male,
  isEmailVerified: true,
);