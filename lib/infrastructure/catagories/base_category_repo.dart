import 'package:fresh_mart/domain/models/category_model.dart';

abstract class BaseCategoryRepository {
  Stream<List<CategoryModel>>  getAllCategories();
}