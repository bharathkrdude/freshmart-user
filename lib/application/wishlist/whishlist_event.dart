part of 'whishlist_bloc.dart';


class WishlistEvent  extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWishList extends WishlistEvent {
  final String email;

  LoadWishList({required this.email});
   @override
  List<Object> get props => [email];
}

class UpdateWishlist extends WishlistEvent {
  final WishlistModel wishlist;

  const UpdateWishlist(this.wishlist);

  @override
  List<Object> get props => [wishlist];
}
class RemoveWishlist extends WishlistEvent {
  final int productId;
  final String wishlistId;

  const RemoveWishlist({required this.wishlistId,required this.productId});

  @override
  List<Object> get props => [wishlistId,productId];
}
class AddToWishlist extends WishlistEvent {
  final int productId;
  final String wishlistId;

  const AddToWishlist({required this.wishlistId,required this.productId});

  @override
  List<Object> get props => [wishlistId,productId];
}