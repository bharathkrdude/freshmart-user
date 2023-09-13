import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WishlistModel extends Equatable {
  final String id;
  final String email;
  final List<int> productList;
  const WishlistModel({
    required this.id,
    required this.productList,
    required this.email,
  });

  @override
  List<Object?> get props => [
        id,
        productList,
        email,
      ];

 

  Map<String, dynamic> toMap() => {
        'id': id,
        'productList': productList,
        'email' : email
      };

  factory WishlistModel.fromSnapshot(DocumentSnapshot snap) {
    List<int> productList = (snap['productList'] as List<dynamic>).map((item) => item as int).toList();

    return WishlistModel(
      id: snap['id'],
      productList: productList,
      email : snap['email'],
    );
  }

  String toJson() => json.encode(toMap());


  
}