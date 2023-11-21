import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_mart/domain/models/adress_model.dart';
import 'package:fresh_mart/infrastructure/address/base_adress_repo.dart';


class AddressRepository extends BaseAddressRepository {
  final FirebaseFirestore _firebaseFirestore;

  AddressRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<AddressModel>> getAllAddresses(String email) {
    return _firebaseFirestore
        .collection('users').doc(email).collection('addresses')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AddressModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Future<void> updateAddress(String email,String addressId, AddressModel address) async{
    try {
      await _firebaseFirestore.collection('users').doc(email).collection('addresses').doc(addressId).set(
            address.toMap(),
            SetOptions(merge: true),
          );
      log('address updated successfully.');
    } catch (error) {
      log('Error updating address: $error');
    }
  }

  
  @override
  Future<void> deleteAddress(String email,String addressId) async{
    try {
      await _firebaseFirestore.collection('users').doc(email).collection('addresses').doc(addressId).delete();
      log('address deleted successfully.');
    } catch (error) {
      log('Error deleting address: $error');
    }
  } 
}
