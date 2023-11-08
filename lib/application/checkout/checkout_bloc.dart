import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../../domain/models/adress_model.dart';
import '../../domain/models/cart_model.dart';
import '../../domain/models/order_model.dart';
import '../../infrastructure/cart/cart_repository.dart';
import '../../infrastructure/order/order_repository.dart';
import '../address/address_bloc.dart';
import '../cart/cart_bloc.dart';
import '../payment/payment_bloc.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final AddressBloc _addressBloc;
  final PaymentBloc _paymentBloc;
  final OrderRepository _orderRepository;
  final CartRepository _cartRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _addressSubscription;
  StreamSubscription? _paymentSubscription;
  CheckoutBloc({
    required CartRepository cartRepository,
    required OrderRepository orderRepository,
    required CartBloc cartBloc,
    required AddressBloc addressBloc,
    required PaymentBloc paymentBloc,
  })  : _cartBloc = cartBloc,
        _addressBloc = addressBloc,
        _paymentBloc = paymentBloc,
        _orderRepository = orderRepository,
        _cartRepository = cartRepository,
        super(CheckoutLoading()) {
    on<CheckoutUpdated>(_onCheckoutUpdated);
    on<CheckoutConfirmed>(_onCheckoutConfirmed);

    _cartSubscription = _cartBloc.stream.listen((state) {
      if (state is CartLoaded) {
        add(CheckoutUpdated(cart: state.cart));
      }
    });
    _addressSubscription = _addressBloc.stream.listen((state) {
      if (state is AddressLoadedSuccess) {
        add(CheckoutUpdated(address: state.address));
      }
    });
    _paymentSubscription = _paymentBloc.stream.listen((state) {
      if (state is PaymentLoaded) {
        add(CheckoutUpdated(paymentMethod: state.paymentMethod));
      }
    });
  }

  void _onCheckoutUpdated(CheckoutUpdated event, Emitter<CheckoutState> emit) {
    log('<<<<<<<<<<<checkout update event>>>>>>>>>>>');
    if (_cartBloc.state is CartLoaded &&
        _addressBloc.state is AddressLoadedSuccess &&
        _paymentBloc.state is PaymentLoaded) {
        emit(CheckoutLoaded(
          cart: (_cartBloc.state as CartLoaded).cart,
          address: (_addressBloc.state as AddressLoadedSuccess).address,
          paymentMethod: (_paymentBloc.state as PaymentLoaded).paymentMethod,
        ));
    }
    if (state is CheckoutLoaded) {
        final state = this.state as CheckoutLoaded;
        emit(CheckoutLoaded(
          cart: event.cart ?? state.cart,
          address: event.address ?? state.address,
          paymentMethod: event.paymentMethod ?? state.paymentMethod,
          order: state.order,
        ));
      }
  }

  void _onCheckoutConfirmed(
      CheckoutConfirmed event, Emitter<CheckoutState> emit) async {
    log('<<<<<<<<<<<checkout confirm event>>>>>>>>>>>');
    final order = FirebaseFirestore.instance.collection('users').doc(event.email).collection('orders').doc();

    log('<<<<<<<<<<<<<checkout bloc>>>>>>>>>>>>>');
    try {
      final state = this.state;

      if (state is CheckoutLoaded) {
        log('<<<<<<<<before placing>>>>>>>>');
        log(state.cart.productsMap.toString());
        log(state.address.toString());
        log(state.paymentMethod.toString());
        log(state.cart.grandTotal.toString());
        log('<<<<<<<end>>>>>>>');
      final List<Map<String, dynamic>> orderDetailsMap = [];
      state.cart.productsMap.forEach((key, value) {
        Map<String, dynamic> eachOrder = {
          'orderId': order.id,
          'productId': key.id,
          'quantity': value,
          'isConfirmed': false,
          'confirmedAt': '',
          'isProcessed': false,
          'processedAt': '',
          'isShipped': false,
          'shippedAt': '',
          'isDelivered': false,
          'deliveredAt': '',
          'isCancelled': false,
          'cancelledAt': '',
        };
        orderDetailsMap.add(eachOrder);
      });
      final String modeOfPayment =
          (state.paymentMethod == PaymentMethod.razor_pay)
              ? 'Razor Pay'
              : 'Cash on Delivery';
      final OrderModel newOrder = OrderModel(
        id: order.id,
        email: event.email,
        orderDetailsMap: orderDetailsMap,
        address: state.address,
        paymentMethod: modeOfPayment,
        placedAt: DateFormat('MMM d, yyyy').format(DateTime.now()),
        isPlaced: true,
        isConfirmed: false,
        isCancelled: false,
        subTotal: state.cart.subTotal,
        deliveryFee: state.cart.deliveryFee,
        grandTotal: state.cart.grandTotal,
      );
      final CartModel updatedCart = CartModel(
        id: state.cart.id,
        productsMap: const {},
        userEmail: event.email,
        subTotal: 0,
        deliveryFee: 0,
        grandTotal: 0,
      );
      await _orderRepository.placeOrder(
          event.email, order.id, newOrder);
      await _cartRepository.updateCartProducts(
          event.email, state.cart.id, updatedCart);
      }
      log('order updated succcessfully');
      log('cart updated succcessfully');
    } catch (e) {
      emit(CheckoutError());
      log('Error: $e');
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _addressSubscription?.cancel();
    _paymentSubscription?.cancel();
    return super.close();
  }
}
