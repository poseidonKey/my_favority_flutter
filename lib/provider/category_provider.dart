import 'package:fav_flutter/model/category_model.dart';
import 'package:fav_flutter/repository/category_load_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryListProvider =
    StateNotifierProvider<CategoryListNotifier, List<CategoryModel>>(
  (ref) => CategoryListNotifier(),
);

class CategoryListNotifier extends StateNotifier<List<CategoryModel>> {
  CategoryListNotifier() : super([]) {
    final tmp = getCategoryData();
    tmp.then((value) => state = value);
  }

  Future<List<CategoryModel>> getCategoryData() async {
    CategoryLoadRepository repository = CategoryLoadRepository();
    final dbData = await repository.getCategories();
    return dbData;
  }
}
