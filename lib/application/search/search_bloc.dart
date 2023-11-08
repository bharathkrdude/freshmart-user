import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/search/search_state.dart';
import 'package:fresh_mart/domain/models/product_model.dart';
import 'package:fresh_mart/infrastructure/catagories/category_repository.dart';
import 'package:fresh_mart/infrastructure/products/product_repository.dart';

part 'search_event.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository productRepository;

  SearchBloc({required this.productRepository, required CategoryRepository categoryRepository}) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is PerformSearch) {
      yield* _mapPerformSearchToState(event);
    }
  }

  Stream<SearchState> _mapPerformSearchToState(PerformSearch event) async* {
    yield SearchLoading();

    try {
      final products = await productRepository.searchProducts(event.query);
      yield SearchSuccess(products as List<ProductModel>);
    } catch (e) {
      yield SearchFailure('An error occurred while searching.');
    }
  }
}
