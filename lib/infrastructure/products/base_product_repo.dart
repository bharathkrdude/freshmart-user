
import 'package:fresh_mart/domain/models/product_model.dart';

abstract class BaseProductRepository {
  Stream<List<ProductModel>> getAllProducts();
  
}