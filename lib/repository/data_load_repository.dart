import 'package:dio/dio.dart';
import 'package:fav_flutter/model/data_model.dart';

class DataLoadRepository {
  final _dio = Dio();

  Future<List<DataModel>> getCategories({required String category}) async {
    print(category);
    String targetUrl =
        'http://192.168.219.106/fav_flutter/load_fav_data.php?category=$category';
    final resp = await _dio.get(targetUrl);
    // return resp.data;
    return resp.data
        .map<DataModel>(
          (x) => DataModel.fromJson(
            json: x,
          ),
        )
        .toList();
  }
}
