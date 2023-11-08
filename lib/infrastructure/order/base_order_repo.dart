

import '../../domain/models/order_model.dart';

abstract class BaseOrderRepository {
  Stream<List<OrderModel>> getAllOrders(String email);
  Future<void> placeOrder(String email,String orderId,OrderModel order);
  Future<void> updateOrder(String email,OrderModel order);
}