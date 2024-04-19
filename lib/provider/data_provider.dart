import 'package:dio/dio.dart';
import 'package:fav_flutter/const/util.dart';
import 'package:fav_flutter/model/data_model.dart';
import 'package:fav_flutter/repository/data_load_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataNotifierProvider =
    StateNotifierProvider.family<DataNotifier, List<DataModel>, String>(
        (ref, category) => DataNotifier(category: category));

class DataNotifier extends StateNotifier<List<DataModel>> {
  final String category;
  DataNotifier({required this.category}) : super([]) {
    // print(category);
    final tmp = getCategoryData(category: category);
    tmp.then((value) => state = value);
  }
  Future<List<DataModel>> getCategoryData({required String category}) async {
    DataLoadRepository repository = DataLoadRepository();
    final dbData = await repository.getCategories(category: category);
    // print(dbData);
    return dbData;
  }

  Future<String> deleteData({required String no}) async {
    // print(category);
    final dio = Dio();
    String targetUrl = '${Util.url}delete_fav_data.php?no=$no';
    await dio.get(targetUrl);
    state = await getCategoryData(category: category);
    return 'delete Data';
  }
}
