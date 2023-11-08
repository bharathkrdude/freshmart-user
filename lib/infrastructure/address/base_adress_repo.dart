import 'package:fresh_mart/domain/models/adress_model.dart';

abstract class BaseAddressRepository {
  Stream<List<AddressModel>> getAllAddresses();
  Future<void> updateAddress(String addressId,AddressModel address);
  Future<void> deleteAddress(String addressId);
}