import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/domain/models/whislist_model.dart';
import 'package:fresh_mart/infrastructure/favourites/whislistrepository.dart';

part 'whishlist_event.dart';
part 'whishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WhislistRepository _whislistRepository;
  StreamSubscription? _whislistSubscription;
  WishlistBloc({required WhislistRepository whislistRepository})
      : _whislistRepository = whislistRepository,
        super(WishlistLoading()) {
    on<LoadWishList>(_onLoadwishlist);
    on<UpdateWishlist>(_onUpdateWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveWishlist>(_onRemoveWishlist);
  }

  void _onLoadwishlist(LoadWishList event, Emitter<WishlistState> emit) {
    _whislistSubscription?.cancel();
    _whislistSubscription = _whislistRepository.getProducts().listen(
          (wishlist) => add(
            UpdateWishlist(
                wishlist.firstWhere((element) => element.email == event.email)),
          ),
        );
  }

  void _onUpdateWishlist(
      UpdateWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        WishlistLoaded(
          wishlist: event.wishlist,
        ),
      );
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onAddToWishlist(
      AddToWishlist event, Emitter<WishlistState> emit) async {
    try {
      final state = this.state;
      if (state is WishlistLoaded) {
        final List<int> updatedList = state.wishlist.productList;
        updatedList.add(event.productId);
        WishlistModel updatedWishlist = WishlistModel(
          id: event.wishlistId,
          productList: updatedList,
          email: state.wishlist.email,
        );
        _whislistRepository.updateWishlistProducts(event.wishlistId, updatedWishlist);
        emit(
        WishlistLoaded(
          wishlist: updatedWishlist,
        ),
      );
      }
      
      
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onRemoveWishlist(RemoveWishlist event, Emitter<WishlistState> emit) {
    try {
      final state = this.state;
      if (state is WishlistLoaded) {
        final List<int> updatedList = state.wishlist.productList;
        updatedList.remove(event.productId);
        WishlistModel updatedWishlist = WishlistModel(
          id: event.wishlistId,
          productList: updatedList,
          email: state.wishlist.email,
        );
        _whislistRepository.updateWishlistProducts(event.wishlistId, updatedWishlist);
        emit(
        WishlistLoaded(
          wishlist: updatedWishlist,
        ),
      );
      }
      
      
    } catch (e) {
      log('Something went wrong: $e');
    }
  }
}
