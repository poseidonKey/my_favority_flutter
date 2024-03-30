import 'package:dio/dio.dart';
import 'package:fav_flutter/model/category_model.dart';

class CategoryLoadRepository {
  final _dio = Dio();
  final _targetUrl = 'http://192.168.219.106/fav_flutter/load_fav_category.php';

  Future<List<CategoryModel>> getCategories() async {
    final resp = await _dio.get(_targetUrl);
    return resp.data
        .map<CategoryModel>(
          (x) => CategoryModel.fromJson(
            json: x,
          ),
        )
        .toList();
  }
}
