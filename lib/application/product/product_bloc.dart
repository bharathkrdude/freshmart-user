import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/domain/models/product_model.dart';
import 'package:fresh_mart/infrastructure/products/product_repository.dart';


part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;
  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) {
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getAllProducts().listen(
          (products) => add(
            UpdateProducts(products),
          ),
        );
  }

  void _onUpdateProducts(
      UpdateProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        ProductLoaded(
          products: event.products,
        ),
      );
    } catch (e) {
      const Text('Something went wrong');
    }
  }

}
