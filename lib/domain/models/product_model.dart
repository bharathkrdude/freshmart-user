import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';



// ignore: must_be_immutable
class ProductModel extends Equatable {
  final int id;
  final String name;
  final String category;
  final String description;
  final List<dynamic> imageUrls;
  final bool isRecommended;
  final bool isTodaySpecial;
  double price;
  int quantity;
  String unit;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrls,
    required this.isRecommended,
    required this.isTodaySpecial,
    this.price = 0,
    this.quantity = 0,
    this.unit = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        description,
        imageUrls,
        isRecommended,
        isTodaySpecial,
        price,
        quantity,
        unit
      ];

  ProductModel copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
    List<dynamic>? imageUrls,
    bool? isRecommended,
    bool? isTodaySpecial,
    double? price,
    int? quantity,
    String? unit,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      isRecommended: isRecommended ?? this.isRecommended,
      isTodaySpecial: isTodaySpecial ?? this.isTodaySpecial,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        'imageUrls': imageUrls,
        'isRecommended': isRecommended,
        'isTodaySpecial': isTodaySpecial,
        'price': price,
        'quantity': quantity,
        'unit' : unit,
      };

  factory ProductModel.fromSnapshot(DocumentSnapshot snap) {
    return ProductModel(
      id: snap['id'],
      name: snap['name'],
      category: snap['category'],
      description: snap['description'],
      imageUrls: snap['imageUrls'],
      isRecommended: snap['isRecommended'],
      isTodaySpecial: snap['isTodaySpecial'],
      price: snap['price'],
      quantity: snap['quantity'],
      unit: snap['unit'],
    );
  }
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      imageUrls: json['imageUrls'],
      isRecommended: json['isRecommended'],
      isTodaySpecial: json['isTodaySpecial'],
      price: json['price'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }


  String toJson() => json.encode(toMap());
  
  @override
  bool get stringify => true;
}