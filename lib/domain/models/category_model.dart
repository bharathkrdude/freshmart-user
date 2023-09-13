import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  const CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
      ];

  CategoryModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
      };

  factory CategoryModel.fromSnapshot(DocumentSnapshot snap) {
    return CategoryModel(
      id: snap['id'],
      name: snap['name'],
      imageUrl: snap['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  
}
