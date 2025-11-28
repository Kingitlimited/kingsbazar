/// lib/models/address_model.dart
/// Complete Address model – fully fixed, no compilation errors

class AddressModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String alternatePhone;
  final String pincode;
  final String state;
  final String city;
  final String houseNo;
  final String roadArea;
  final String landmark;
  final AddressType type;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.alternatePhone = '',
    required this.pincode,
    required this.state,
    required this.city,
    required this.houseNo,
    required this.roadArea,
    this.landmark = '',
    this.type = AddressType.home,
    this.isDefault = false,
  });

  // JSON → Model
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      alternatePhone: json['alternatePhone'] ?? '',
      pincode: json['pincode'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      houseNo: json['houseNo'] ?? '',
      roadArea: json['roadArea'] ?? '',
      landmark: json['landmark'] ?? '',
      type: _parseType(json['type']),
      isDefault: json['isDefault'] ?? false,
    );
  }

  // Model → JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'alternatePhone': alternatePhone,
        'pincode': pincode,
        'state': state,
        'city': city,
        'houseNo': houseNo,
        'roadArea': roadArea,
        'landmark': landmark,
        'type': type.name,
        'isDefault': isDefault,
      };

  String get fullAddress =>
      '$houseNo, $roadArea${landmark.isNotEmpty ? ', $landmark' : ''}, $city, $state - $pincode';

  String get typeLabel => switch (type) {
        AddressType.home => 'Home',
        AddressType.work => 'Work',
        AddressType.other => 'Other',
      };

  AddressModel copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? alternatePhone,
    String? pincode,
    String? state,
    String? city,
    String? houseNo,
    String? roadArea,
    String? landmark,
    AddressType? type,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      alternatePhone: alternatePhone ?? this.alternatePhone,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      city: city ?? this.city,
      houseNo: houseNo ?? this.houseNo,
      roadArea: roadArea ?? this.roadArea,
      landmark: landmark ?? this.landmark,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  static AddressType _parseType(String? type) {
    return AddressType.values.firstWhere(
      (e) => e.name == type?.toLowerCase(),
      orElse: () => AddressType.home,
    );
  }
}

enum AddressType { home, work, other }