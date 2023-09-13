part of 'whishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
  
  @override
  List<Object> get props => [];
}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final WishlistModel wishlist;

  const WishlistLoaded( {required this.wishlist});

  @override
  List<Object> get props => [wishlist];
}

class WishlistError extends WishlistState {}
