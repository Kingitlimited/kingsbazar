/// lib/providers/address_provider.dart
/// FULL — 1 default address on first launch

import 'dart:convert';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kingsbazar/models/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressNotifier extends StateNotifier<List<AddressModel>> {
  AddressNotifier() : super([]) {
    _loadOrCreateDefault();
  }

  Future<void> _loadOrCreateDefault() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('addresses');
    if (jsonString != null && jsonString.isNotEmpty) {
      final List<dynamic> list = json.decode(jsonString);
      state = list.map((e) => AddressModel.fromJson(e)).toList();
    } else {
      state = [_createDefaultAddress()];
      _save();
    }
  }

  AddressModel _createDefaultAddress() => AddressModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: "Your Name",
        phoneNumber: "9876543210",
        pincode: "110001",
        state: "Delhi",
        city: "New Delhi",
        houseNo: "A-12",
        roadArea: "Safdarjung Enclave",
        type: AddressType.home,
        isDefault: true,
      );

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(state.map((e) => e.toJson()).toList());
    await prefs.setString('addresses', jsonString);
  }

  void addAddress(AddressModel address) {
    if (address.isDefault) {
      state = state.map((a) => a.copyWith(isDefault: false)).toList();
    }
    state = [...state, address];
    _save();
  }

  void updateAddress(AddressModel updated) {
    state = state.map((a) => a.id == updated.id ? updated : a).toList();
    _save();
  }

  void deleteAddress(String id) {
    state = state.where((a) => a.id != id).toList();
    if (state.isNotEmpty && !state.any((a) => a.isDefault)) {
      state = [state.first.copyWith(isDefault: true), ...state.skip(1)];
    }
    _save();
  }

  void setDefault(String id) {
    state = state.map((a) => a.copyWith(isDefault: a.id == id)).toList();
    _save();
  }
}

final addressProvider = StateNotifierProvider<AddressNotifier, List<AddressModel>>((ref) {
  return AddressNotifier();
});