import 'package:equatable/equatable.dart';
import 'package:fresh_mart/domain/models/product_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductModel> products;

  SearchSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure(this.error);

  @override
  List<Object?> get props => [error];
}